import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/common/layout/breakpoints.dart';
import 'package:scores_2_go/common/widget/empty_state.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/scores/bloc/scores_bloc.dart';
import 'package:scores_2_go/scores/widget/score_list_view.dart';
import 'package:scores_2_go/scores/widget/searchbar.dart';

class ScoresScreen extends StatelessWidget {
  const ScoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return BlocConsumer<ScoresBloc, ScoresState>(
      listener: (context, state) {},
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= kMobileBreakpoint;

            Widget listBody;
            if (state.status == ScoresStatus.loading) {
              listBody = const Center(child: CircularProgressIndicator());
            } else if (state.status == ScoresStatus.failure) {
              listBody = const EmptyState.error();
            } else if (state.scores.isEmpty && state.showSearch) {
              listBody = EmptyState(
                title: l.noResultsFound,
                subtitle: l.tryDifferentSearch,
              );
            } else if (state.scores.isEmpty) {
              listBody = EmptyState(
                title: l.noScoresAvailable,
                subtitle: l.addScoresOrCheckConnection,
              );
            } else {
              listBody = ScoreListView(scoresToDisplay: state.scores);
            }

            // ── Wide: persistent search bar above the list ───────────────
            if (isWide) {
              return SafeArea(
                child: Scaffold(
                  appBar: AppBar(title: Text(l.scores)),
                  body: Column(
                    children: [
                      _WideSearchBar(),
                      Expanded(child: listBody),
                    ],
                  ),
                ),
              );
            }

            // ── Mobile: floating FAB search toggle ───────────────────────
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(title: Text(l.scores)),
                body: Stack(
                  children: [
                    listBody,
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ScoreSearchBar(showSearch: state.showSearch),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _WideSearchBar extends StatefulWidget {
  @override
  State<_WideSearchBar> createState() => _WideSearchBarState();
}

class _WideSearchBarState extends State<_WideSearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Score suchen',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _controller.clear();
                    context
                        .read<ScoresBloc>()
                        .add(SearchScoresEvent(searchString: ''));
                  },
                )
              : null,
          filled: true,
          fillColor: cs.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onChanged: (value) {
          setState(() {});
          context
              .read<ScoresBloc>()
              .add(SearchScoresEvent(searchString: value));
        },
      ),
    );
  }
}

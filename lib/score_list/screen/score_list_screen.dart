import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/auth/screen/open_auth_screen.dart';
import 'package:scores_2_go/common/layout/breakpoints.dart';
import 'package:scores_2_go/common/widget/empty_state.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/repo/feedback_repository.dart';
import 'package:scores_2_go/score_list/bloc/scores_bloc.dart';
import 'package:scores_2_go/score_list/widget/feedback_dialog.dart';
import 'package:scores_2_go/score_list/widget/score_list_view.dart';
import 'package:scores_2_go/score_list/widget/searchbar.dart';

class ScoreListScreen extends StatelessWidget {
  const ScoreListScreen({super.key});

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
            } else if (state.scores.isEmpty && state.searchString.isNotEmpty) {
              listBody = _SearchEmptyState(searchQuery: state.searchString);
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
                    context.read<ScoresBloc>().add(
                      SearchScoresEvent(searchString: ''),
                    );
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
          context.read<ScoresBloc>().add(
            SearchScoresEvent(searchString: value),
          );
        },
      ),
    );
  }
}

class _SearchEmptyState extends StatelessWidget {
  const _SearchEmptyState({required this.searchQuery});

  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off, size: 48),
            const SizedBox(height: 8),
            Text(
              l.noResultsFound,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(l.tryDifferentSearch),
            const SizedBox(height: 24),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                if (!ensureSignedIn(context, message: l.signInToSendFeedback)) {
                  return;
                }
                showDialog<void>(
                  context: context,
                  builder: (_) => FeedbackDialog(
                    repository: context.read<FeedbackRepository>(),
                    initialText: searchQuery.isNotEmpty
                        ? l.missingScorePrefill(searchQuery)
                        : null,
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: cs.outlineVariant),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 20,
                      color: cs.onSurfaceVariant,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l.reportMissingScore,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          l.reportMissingScoreSubtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: cs.onSurfaceVariant.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.open_in_new,
                      size: 16,
                      color: cs.onSurfaceVariant.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

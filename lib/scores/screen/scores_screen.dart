import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(title: Text(l.scores)),
            body: Stack(
              children: [
                if (state.status == ScoresStatus.loading)
                  const Center(child: CircularProgressIndicator())
                else if (state.status == ScoresStatus.failure)
                  const EmptyState.error()
                else if (state.status == ScoresStatus.success)
                  if (state.scores.isEmpty && state.showSearch)
                    EmptyState(
                      title: l.noResultsFound,
                      subtitle: l.tryDifferentSearch,
                    )
                  else if (state.scores.isEmpty)
                    EmptyState(
                      title: l.noScoresAvailable,
                      subtitle: l.addScoresOrCheckConnection,
                    )
                  else
                    ScoreListView(scoresToDisplay: state.scores),
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
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go_2/common/widget/empty_state.dart';
import 'package:scores_2_go_2/scores/bloc/scores_bloc.dart';
import 'package:scores_2_go_2/scores/widget/score_list_view.dart';
import 'package:scores_2_go_2/scores/widget/searchbar.dart';

class ScoresScreen extends StatelessWidget {
  const ScoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScoresBloc, ScoresState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(title: const Text('Scores')),
            body: Stack(
              children: [
                if (state.status == ScoresStatus.initial)
                  const Center(child: Text('Initialer Zustand'))
                else if (state.status == ScoresStatus.loading)
                  const Center(child: CircularProgressIndicator())
                else if (state.status == ScoresStatus.failure)
                  const EmptyState.error()
                else if (state.status == ScoresStatus.success)
                  if (state.scores.isEmpty && state.showSearch)
                    const EmptyState(
                      title: 'Keine Ergebnisse gefunden',
                      subtitle: 'Anderen Suchbegriff versuchen.',
                    )
                  else if (state.scores.isEmpty)
                    const EmptyState(
                      title: 'Keine Scores vorhanden',
                      subtitle: 'Scores hinzufügen oder Verbindung prüfen.',
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

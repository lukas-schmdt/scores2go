import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go_2/model/score.dart';
import 'package:scores_2_go_2/scores/bloc/scores_bloc.dart';
import 'package:scores_2_go_2/scores/widget/score_list_item.dart';
import 'package:scores_2_go_2/user_favorites/bloc/user_favorites_bloc.dart';

class ScoreListView extends StatelessWidget {
  const ScoreListView({super.key, required this.scoresToDisplay});

  final List<Score> scoresToDisplay;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<ScoresBloc>().add(LoadScoresEvent(force: true)),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: scoresToDisplay.length + 1,
        itemBuilder: (context, index) {
          final sortedScores = [...scoresToDisplay]
            ..sort((a, b) => a.display.compareTo(b.display));

          if (index == scoresToDisplay.length) {
            return const SizedBox(height: 48);
          }

          final score = sortedScores[index];
          final isFavorite = context
              .watch<UserFavoritesBloc>()
              .state
              .favorites
              .contains(score.id);

          return ScoreListItem(score: score, isFavorite: isFavorite);
        },
      ),
    );
  }
}

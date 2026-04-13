import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/score_list/bloc/scores_bloc.dart';
import 'package:scores_2_go/score_list/widget/score_list_item.dart';
import 'package:scores_2_go/user_favorites/bloc/user_favorites_bloc.dart';

class ScoreListView extends StatelessWidget {
  const ScoreListView({super.key, required this.scoresToDisplay});

  final List<Score> scoresToDisplay;

  @override
  Widget build(BuildContext context) {
    final sortedScores = [...scoresToDisplay]
      ..sort((a, b) => a.display.compareTo(b.display));

    final favorites = context.watch<UserFavoritesBloc>().state.favorites;

    return RefreshIndicator(
      onRefresh: () async =>
          context.read<ScoresBloc>().add(LoadScoresEvent(force: true)),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: sortedScores.length + 1,
        itemBuilder: (context, index) {
          if (index == sortedScores.length) {
            return const SizedBox(height: 64);
          }
          final score = sortedScores[index];
          return ScoreListItem(
            score: score,
            isFavorite: favorites.contains(score.id),
          );
        },
      ),
    );
  }
}

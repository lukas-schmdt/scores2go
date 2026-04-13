import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/score_list/bloc/scores_bloc.dart';
import 'package:scores_2_go/score_list/widget/score_list_item.dart';
import 'package:scores_2_go/user_favorites/bloc/user_favorites_bloc.dart';
import 'package:scores_2_go/repo/feedback_repository.dart';
import 'package:scores_2_go/score_list/widget/feedback_dialog.dart';

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
            return const _MissingScoreFooter();
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

class _MissingScoreFooter extends StatelessWidget {
  const _MissingScoreFooter();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => showDialog<void>(
          context: context,
          builder: (_) => FeedbackDialog(
            repository: context.read<FeedbackRepository>(),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.add_circle_outline, size: 20, color: cs.onSurfaceVariant),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Score missing?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      'Tap to request a new score',
                      style: TextStyle(
                        fontSize: 12,
                        color: cs.onSurfaceVariant.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.open_in_new, size: 16,
                  color: cs.onSurfaceVariant.withValues(alpha: 0.5)),
            ],
          ),
        ),
      ),
    );
  }
}

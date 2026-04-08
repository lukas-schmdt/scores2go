import 'package:flutter/material.dart';
import 'package:scores_2_go/home/widgets/favorite_icon_button.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/score_entry/screen/open_score_entry.dart';

class ScoreListItem extends StatelessWidget {
  const ScoreListItem({
    super.key,
    required this.score,
    required this.isFavorite,
  });

  final Score score;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        onTap: () => openScoreEntry(context, score),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      score.display,
                      style: tt.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (score.description.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        score.description,
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              FavoriteIconButton(
                isFavorite: isFavorite,
                scoreId: score.id,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

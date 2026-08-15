import 'package:flutter/material.dart';
import 'package:scores_2_go/auth/screen/open_auth_screen.dart';
import 'package:scores_2_go/collections/widget/add_to_collection_sheet.dart';
import 'package:scores_2_go/home/widgets/favorite_icon_button.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
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

    final metaStyle = tt.labelSmall?.copyWith(color: cs.onSurfaceVariant);
    final hasDescription = score.description.isNotEmpty;
    final hasMetadata =
        score.author != null ||
        score.year != null ||
        score.popularity != null ||
        score.categories.isNotEmpty;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      elevation: 2,
      child: InkWell(
        onTap: () => openScoreEntry(context, score),
        borderRadius: BorderRadius.circular(12),
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
                    if (hasDescription) ...[
                      const SizedBox(height: 4),
                      Text(
                        score.description,
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (hasMetadata) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: cs.outlineVariant,
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          if (score.author != null || score.year != null)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.person_outline,
                                  size: 12,
                                  color: cs.onSurfaceVariant,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  [
                                    if (score.author != null) score.author!,
                                    if (score.year != null) '${score.year}',
                                  ].join(', '),
                                  style: metaStyle,
                                ),
                              ],
                            ),
                          if (score.popularity != null)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  size: 12,
                                  color: cs.onSurfaceVariant,
                                ),
                                const SizedBox(width: 3),
                                Text('${score.popularity}', style: metaStyle),
                              ],
                            ),
                          for (final cat in score.categories)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 1,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: cs.outlineVariant),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(cat, style: metaStyle),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(
                width: 40,
                height: 40,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.folder_outlined, color: cs.onSurfaceVariant),
                  onPressed: () {
                    final l = AppLocalizations.of(context)!;
                    if (!ensureSignedIn(context, message: l.signInToUseCollections)) {
                      return;
                    }
                    showAddToCollectionDialog(context, score.id);
                  },
                ),
              ),
              FavoriteIconButton(isFavorite: isFavorite, scoreId: score.id),
            ],
          ),
        ),
      ),
    );
  }
}

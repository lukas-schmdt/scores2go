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
    return Column(
      children: [
        ListTile(
          title: Text(
            score.display,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(score.description),
          trailing: FavoriteIconButton(
            isFavorite: isFavorite,
            scoreId: score.id,
          ),
          onTap: () => openScoreEntry(context, score),
        ),
        const Divider(thickness: 1, height: 1),
      ],
    );
  }
}

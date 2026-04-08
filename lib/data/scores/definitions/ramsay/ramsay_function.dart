import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

ScoreResult ramsayFunction(Score score) {
  final ctx = FlatScoreContext(score: score);
  final level = ctx.singleSelect('ramsay-level')?['value'] as num?;

  if (level == null) {
    return ScoreResult.incomplete(
      label: 'Ramsay-Skala',
      interpretation: 'Bitte Sedierungsgrad auswählen.',
    );
  }

  final value = level.toInt();
  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'Ramsay-Grad',
    primaryResult: 'Stufe $value',
    primaryInterpretation: _interpretation(value),
    secondaryLabel: 'Bewertung',
    secondaryResult: _rating(value),
  );
}

String _interpretation(int v) => switch (v) {
      1 => 'Ängstlich, agitiert oder unruhig',
      2 => 'Kooperativ, orientiert und ruhig',
      3 => 'Reagiert nur auf Aufforderung',
      4 => 'Schlafend; prompte Reaktion auf Glabellaschlag oder lauten Stimulus',
      5 => 'Schlafend; träge Reaktion auf Glabellaschlag oder lauten Stimulus',
      6 => 'Schlafend; keine Reaktion auf Stimulus',
      _ => '',
    };

String _rating(int v) => switch (v) {
      1 => 'Unzureichende Sedierung – Patient agitiert',
      2 || 3 => 'Angestrebtes Sedierungsziel',
      4 || 5 => 'Tiefe Sedierung – Ziel überprüfen',
      6 => 'Sehr tiefe Sedierung – Überdosierung möglich',
      _ => '',
    };

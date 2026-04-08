import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

ScoreResult rassFunction(Score score) {
  final ctx = FlatScoreContext(score: score);
  final level = ctx.singleSelect('rass-level')?['value'] as num?;

  if (level == null) {
    return ScoreResult.incomplete(
      label: 'RASS',
      interpretation: 'Bitte RASS-Grad auswählen.',
    );
  }

  final value = level.toInt();
  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'RASS',
    primaryResult: value > 0 ? '+$value' : '$value',
    primaryInterpretation: _interpretation(value),
  );
}

String _interpretation(int v) => switch (v) {
      4 => 'Streitlustig – kämpferisch, gefährlich',
      3 => 'Stark agitiert – zieht Zugänge, kämpft gegen Beatmung',
      2 => 'Agitiert – häufige, ungezielte Bewegungen',
      1 => 'Unruhig – ängstlich, aber Bewegungen nicht aggressiv',
      0 => 'Wach und kooperativ',
      -1 => 'Schläfrig – nicht ganz wach, aber auf Stimme wach > 10 s',
      -2 => 'Leichte Sedierung – kurz wach auf Ansprache < 10 s',
      -3 => 'Mäßige Sedierung – Bewegung auf Ansprache, kein Augenkontakt',
      -4 => 'Tiefe Sedierung – keine Reaktion auf Ansprache, Reaktion auf Schmerz',
      -5 => 'Nicht erweckbar – keine Reaktion auf Stimme oder Schmerzreiz',
      _ => '',
    };

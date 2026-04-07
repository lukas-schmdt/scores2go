import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

ScoreResult demoScoreFunction(Score score) {
  final ctx = FlatScoreContext(score: score);

  final o2 = ctx.boolValue('demo-score-o2_therapy');
  final alert = ctx.singleSelect('demo-score-alertness');
  if (o2 == null || alert == null) return ScoreResult.incomplete();

  final vented = ctx.boolValue('demo-score-ventilated');
  final isVented = (vented?['value'] as bool?) ?? false;
  final fio2 = ctx.singleSelect('demo-score-fio2');
  if (isVented && fio2 == null) return ScoreResult.incomplete();

  final temp = ctx.numValue('demo-score-temperature');
  final comor = ctx.multiSelect('demo-score-comorbidities') ?? [];
  final sugar = ctx.singleSelect('demo-score-blood_sugar');

  final o2Pts = (o2['points'] as num).toInt();
  final alertPts = (alert['value'] as num).toInt();
  final fio2Pts = isVented ? (fio2!['value'] as num).toInt() : 0;
  final comorPts = comor.fold<int>(
    0,
    (s, c) => s + (c['value'] as num).toInt(),
  );
  final sugarPts = sugar != null ? (sugar['value'] as num).toInt() : 0;
  final total = o2Pts + alertPts + fio2Pts + comorPts + sugarPts;

  final tempAnnotation = temp != null
      ? ' | Temp: ${(temp['value'] as num).toStringAsFixed(1)} °C'
      : '';

  String riskLabel(int t) {
    if (t <= 2) return 'Low';
    if (t <= 5) return 'Medium';
    return 'High';
  }

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'Demo Score Total',
    primaryResult: '$total pts',
    primaryInterpretation:
        'O₂:$o2Pts  |  Alertness:$alertPts'
        '${isVented ? '  |  FiO₂:$fio2Pts' : ''}  |  Comorbid.:$comorPts',
    secondaryLabel: 'Risk Level',
    secondaryResult: riskLabel(total),
    secondaryInterpretation:
        'Score ≤2 → Low | 3–5 → Medium | ≥6 → High$tempAnnotation',
  );
}

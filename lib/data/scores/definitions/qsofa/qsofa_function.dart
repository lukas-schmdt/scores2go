import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

ScoreResult qsofaFunction(Score score) {
  final ctx = FlatScoreContext(score: score);

  final respRate = ctx.boolValue('qsofa-resp-rate')?['points'] as num?;
  final mentation = ctx.boolValue('qsofa-mentation')?['points'] as num?;
  final sbp = ctx.boolValue('qsofa-sbp')?['points'] as num?;

  if (respRate == null || mentation == null || sbp == null) {
    return ScoreResult.incomplete(
      label: 'qSOFA',
      interpretation: 'Please assess all three criteria.',
    );
  }

  final total = (respRate + mentation + sbp).toInt();

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'qSOFA',
    primaryResult: '$total / 3',
    primaryInterpretation: _interpret(total),
  );
}

String _interpret(int total) => total >= 2
    ? 'High risk — increased risk of mortality and prolonged ICU stay. Consider further sepsis workup.'
    : 'Low risk — continue routine monitoring; reassess if clinical status changes.';

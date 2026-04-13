import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

ScoreResult gcsFunction(Score score) {
  final ctx = FlatScoreContext(score: score);

  final e = ctx.singleSelect('gcs-eyes')?['value'] as num?;
  final v = ctx.singleSelect('gcs-verbal')?['value'] as num?;
  final m = ctx.singleSelect('gcs-motor')?['value'] as num?;

  if (e == null && v == null && m == null) {
    return ScoreResult.incomplete(
      label: 'GCS',
      interpretation: 'Select a response in each subscale.',
    );
  }

  // Partial: show running total as soon as any subscale is answered
  final eVal = e?.toInt() ?? 0;
  final vVal = v?.toInt() ?? 0;
  final mVal = m?.toInt() ?? 0;
  final total = eVal + vVal + mVal;

  if (e == null || v == null || m == null) {
    final evm = [
      if (e != null) 'E$eVal',
      if (v != null) 'V$vVal',
      if (m != null) 'M$mVal',
    ].join(' ');
    return ScoreResult(
      state: ScoreState.incomplete,
      primaryLabel: 'GCS (partial)',
      primaryResult: '$total',
      primaryInterpretation: 'Complete all three subscales for full result.',
      secondaryLabel: 'EVM',
      secondaryResult: evm,
    );
  }

  final evm = 'E$eVal V$vVal M$mVal';

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'GCS',
    primaryResult: '$total / 15',
    primaryInterpretation: _interpret(total),
    secondaryLabel: 'EVM',
    secondaryResult: evm,
  );
}

String _interpret(int gcs) {
  if (gcs >= 13) return 'Mild — GCS 13–15';
  if (gcs >= 9) return 'Moderate — GCS 9–12';
  return 'Severe — GCS 3–8';
}

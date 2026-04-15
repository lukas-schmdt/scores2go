import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

ScoreResult camIcuFunction(Score score) {
  final ctx = FlatScoreContext(score: score);

  final f1 = ctx.boolValue('cam-icu-feature1')?['value'] as bool?;
  final f2 = ctx.boolValue('cam-icu-feature2')?['value'] as bool?;

  if (f1 == null || f2 == null) {
    return ScoreResult.incomplete(
      label: 'CAM-ICU',
      interpretation: 'Please assess features 1 and 2.',
    );
  }

  // Early negative: feature 1 or feature 2 absent → CAM-ICU negative
  if (!f1 || !f2) {
    return ScoreResult(
      state: ScoreState.success,
      primaryLabel: 'CAM-ICU',
      primaryResult: 'Negative',
      primaryInterpretation: 'No delirium detected.',
    );
  }

  // Both F1 and F2 positive — need F3 and F4
  final f3 = ctx.boolValue('cam-icu-feature3')?['value'] as bool?;
  final f4 = ctx.boolValue('cam-icu-feature4')?['value'] as bool?;

  if (f3 == null || f4 == null) {
    return ScoreResult.incomplete(
      label: 'CAM-ICU',
      interpretation:
          'Features 1 and 2 are positive. Please assess features 3 and 4.',
    );
  }

  final positive = f3 || f4;

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'CAM-ICU',
    primaryResult: positive ? 'Positive' : 'Negative',
    primaryInterpretation: positive
        ? 'Delirium present — initiate delirium management protocol.'
        : 'No delirium detected.',
  );
}

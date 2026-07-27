import 'package:scores_2_go/data/scores/definitions/icdsc/icdsc_i10n.dart';
import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final _i10n = IcdscI10n();

// Sentinel used for LOC options A/B (coma/stupor) which halt the assessment.
const _notAssessableValue = -1;

ScoreResult icdscFunction(Score score, String lang) {
  String t(String key) => _i10n.t(lang, key);
  final ctx = FlatScoreContext(score: score);

  final loc = ctx.singleSelect('icdsc-loc')?['value'] as num?;

  if (loc == null) {
    return ScoreResult.incomplete(
      label: 'ICDSC',
      interpretation: t('calc.incompleteLoc'),
    );
  }

  // LOC A or B (coma/stupor) halts the assessment — items 2–8 are not
  // rateable and the total is not calculable. This is a distinct outcome,
  // not a total of 0.
  if (loc == _notAssessableValue) {
    return ScoreResult(
      state: ScoreState.success,
      primaryLabel: 'ICDSC',
      primaryResult: t('calc.notAssessableResult'),
      primaryInterpretation: t('calc.notAssessableInterpretation'),
    );
  }

  final inattention = ctx.boolValue('icdsc-inattention')?['value'] as bool?;
  final disorientation =
      ctx.boolValue('icdsc-disorientation')?['value'] as bool?;
  final hallucinations =
      ctx.boolValue('icdsc-hallucinations')?['value'] as bool?;
  final psychomotor = ctx.boolValue('icdsc-psychomotor')?['value'] as bool?;
  final speechMood = ctx.boolValue('icdsc-speech-mood')?['value'] as bool?;
  final sleepWake = ctx.boolValue('icdsc-sleep-wake')?['value'] as bool?;
  final fluctuation = ctx.boolValue('icdsc-fluctuation')?['value'] as bool?;

  if (inattention == null ||
      disorientation == null ||
      hallucinations == null ||
      psychomotor == null ||
      speechMood == null ||
      sleepWake == null ||
      fluctuation == null) {
    return ScoreResult.incomplete(
      label: 'ICDSC',
      interpretation: t('calc.incompleteItems'),
    );
  }

  final total = loc.toInt() +
      (inattention ? 1 : 0) +
      (disorientation ? 1 : 0) +
      (hallucinations ? 1 : 0) +
      (psychomotor ? 1 : 0) +
      (speechMood ? 1 : 0) +
      (sleepWake ? 1 : 0) +
      (fluctuation ? 1 : 0);

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'ICDSC',
    primaryResult: '$total / 8',
    primaryInterpretation: _interpret(total, t),
  );
}

String _interpret(int total, String Function(String) t) {
  if (total == 0) return t('calc.noDeliriumInterpretation');
  if (total <= 3) return t('calc.subsyndromalInterpretation');
  return t('calc.deliriumInterpretation');
}

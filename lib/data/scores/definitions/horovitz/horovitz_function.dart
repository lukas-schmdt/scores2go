import 'package:scores_2_go/data/scores/definitions/horovitz/horovitz_i10n.dart';
import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final _i10n = HorovitzI10n();

ScoreResult horovitzFunction(Score score, String lang) {
  String t(String key) => _i10n.t(lang, key);
  final ctx = FlatScoreContext(score: score);

  // PaO2 is stored in mmHg (canonical unit of Units.pressure).
  // FiO2 is stored as % (21–100).
  final pao2 = ctx.numValue('horovitz-pao2')?['value'] as num?;
  final fio2 = ctx.numValue('horovitz-fio2')?['value'] as num?;

  if (pao2 == null && fio2 == null) {
    return ScoreResult.incomplete(
      label: t('display'),
      interpretation: t('calc.incomplete.enterBoth'),
    );
  }

  if (pao2 == null || fio2 == null) {
    return ScoreResult.incomplete(
      label: t('display'),
      interpretation: pao2 == null
          ? t('calc.incomplete.pao2Missing')
          : t('calc.incomplete.fio2Missing'),
    );
  }

  if (fio2 <= 0) {
    return ScoreResult(
      state: ScoreState.error,
      primaryLabel: t('display'),
      primaryResult: '—',
      primaryInterpretation: t('calc.fio2MustBeGreaterThanZero'),
    );
  }

  // FiO2 stored as %, convert to fraction for the ratio.
  final ratio = pao2.toDouble() / (fio2.toDouble() / 100.0);
  final ratioRounded = ratio.round();

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: t('display'),
    primaryResult: '$ratioRounded mmHg',
    primaryInterpretation: _interpret(ratio, t),
    secondaryLabel: t('calc.inputsLabel'),
    secondaryResult: 'PaO₂ ${pao2.toStringAsFixed(0)} mmHg · FiO₂ ${fio2.toStringAsFixed(0)} %',
  );
}

String _interpret(double ratio, String Function(String) t) {
  if (ratio >= 400) return t('calc.interp.normal');
  if (ratio >= 300) return t('calc.interp.mildHypoxemia');
  if (ratio >= 200) return t('calc.interp.mildArds');
  if (ratio >= 100) return t('calc.interp.moderateArds');
  return t('calc.interp.severeArds');
}

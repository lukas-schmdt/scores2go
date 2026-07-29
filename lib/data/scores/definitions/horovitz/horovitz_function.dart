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
  // PEEP is stored in cmH₂O and is optional — a missing PEEP must never
  // make the score incomplete, it only affects how confidently we can
  // apply the Berlin ARDS labels.
  final pao2 = ctx.numValue('horovitz-pao2')?['value'] as num?;
  final fio2 = ctx.numValue('horovitz-fio2')?['value'] as num?;
  final peep = ctx.numValue('horovitz-peep')?['value'] as num?;

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
  // Interpret on the rounded, displayed value so the shown number and the
  // assigned band can never contradict each other at a boundary.
  final ratioRounded = ratio.round();

  var secondary =
      'PaO₂ ${pao2.toStringAsFixed(0)} mmHg · FiO₂ ${fio2.toStringAsFixed(0)} %';
  if (peep != null) {
    secondary += ' · PEEP ${peep.toStringAsFixed(0)} cmH₂O';
  }

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: t('display'),
    primaryResult: '$ratioRounded mmHg',
    primaryInterpretation: _interpret(ratioRounded, peep, t),
    secondaryLabel: t('calc.inputsLabel'),
    secondaryResult: secondary,
  );
}

/// Berlin Definition bands, upper-bound inclusive, assigned to the worse
/// band at the boundary:
///   Normal / informal:  ratio ≥ 400
///   Mild impairment:    300 < ratio < 400   (non-Berlin, informal)
///   Mild ARDS:          200 < ratio ≤ 300
///   Moderate ARDS:      100 < ratio ≤ 200
///   Severe ARDS:               ratio ≤ 100
///
/// The Berlin ARDS bands are only formally valid on PEEP/CPAP ≥ 5 cmH₂O.
/// Since PEEP is optional here, the ARDS labels are hedged when PEEP is
/// missing, and explicitly flagged as non-applicable when PEEP is entered
/// but below 5 cmH₂O.
String _interpret(int ratio, num? peep, String Function(String) t) {
  if (ratio >= 400) return t('calc.interp.normal');
  if (ratio > 300) return t('calc.interp.mildImpairment');

  final String ardsKeyBase;
  if (ratio > 200) {
    ardsKeyBase = 'calc.interp.mildArds';
  } else if (ratio > 100) {
    ardsKeyBase = 'calc.interp.moderateArds';
  } else {
    ardsKeyBase = 'calc.interp.severeArds';
  }

  if (peep == null) {
    return t('$ardsKeyBase.peepUnknown');
  }
  if (peep < 5) {
    return t('$ardsKeyBase.peepLow');
  }
  return t('$ardsKeyBase.full');
}

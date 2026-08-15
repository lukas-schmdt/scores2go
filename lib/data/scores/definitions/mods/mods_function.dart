import 'package:scores_2_go/data/scores/definitions/mods/mods_i10n.dart';
import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final _i10n = ModsI10n();

ScoreResult modsFunction(Score score, String lang) {
  String t(String key) => _i10n.t(lang, key);
  final ctx = FlatScoreContext(score: score);

  final pf = ctx.singleSelect('mods-pf')?['value'] as num?;
  final creatinine = ctx.singleSelect('mods-creatinine')?['value'] as num?;
  final bilirubin = ctx.singleSelect('mods-bilirubin')?['value'] as num?;
  final platelets = ctx.singleSelect('mods-platelets')?['value'] as num?;
  final gcs = ctx.singleSelect('mods-gcs')?['value'] as num?;

  // Cardiovascular: PAR = HR × CVP / MAP
  final hr = ctx.numValue('mods-hr')?['value'] as num?;
  final map = ctx.numValue('mods-map')?['value'] as num?;
  final cvp = ctx.numValue('mods-cvp')?['value'] as num?;

  final allAnswered = pf != null &&
      creatinine != null &&
      bilirubin != null &&
      platelets != null &&
      gcs != null &&
      hr != null &&
      map != null &&
      cvp != null;

  final anyAnswered = pf != null ||
      creatinine != null ||
      bilirubin != null ||
      platelets != null ||
      gcs != null ||
      hr != null ||
      map != null ||
      cvp != null;

  if (!anyAnswered) {
    return ScoreResult.incomplete(
      label: 'MODS',
      interpretation: t('calc.incomplete'),
    );
  }

  // Cardiovascular score from PAR
  final cardioScore = _cardiovascularScore(hr, map, cvp);

  final total = (pf?.toInt() ?? 0) +
      (creatinine?.toInt() ?? 0) +
      (bilirubin?.toInt() ?? 0) +
      (cardioScore ?? 0) +
      (platelets?.toInt() ?? 0) +
      (gcs?.toInt() ?? 0);

  // Cardiovascular is incomplete if only some of HR/MAP/CVP are entered
  final cardioIncomplete =
      (hr != null || map != null || cvp != null) && cardioScore == null;

  if (!allAnswered || cardioIncomplete) {
    return ScoreResult(
      state: ScoreState.incomplete,
      primaryLabel: t('calc.partialLabel'),
      primaryResult: '$total',
      primaryInterpretation: cardioIncomplete
          ? t('calc.enterCardioValues')
          : t('calc.completeAllSix'),
    );
  }

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'MODS',
    primaryResult: '$total / 24',
    primaryInterpretation: _interpret(total, t),
    secondaryLabel: 'PAR',
    secondaryResult: _parLabel(hr, map, cvp),
  );
}

/// Returns the cardiovascular score (0–4) from PAR = HR × CVP / MAP,
/// or null if any required value is missing.
int? _cardiovascularScore(num? hr, num? map, num? cvp) {
  if (hr == null || map == null || cvp == null) return null;
  if (map == 0) return 4; // avoid division by zero → worst score
  final par = hr.toDouble() * cvp.toDouble() / map.toDouble();
  if (par <= 10) return 0;
  if (par <= 15) return 1;
  if (par <= 20) return 2;
  if (par <= 30) return 3;
  return 4;
}

String _parLabel(num hr, num map, num cvp) {
  if (map == 0) return 'PAR = —';
  final par = hr.toDouble() * cvp.toDouble() / map.toDouble();
  return 'PAR = ${par.toStringAsFixed(1)}';
}

String _interpret(int mods, String Function(String) t) {
  if (mods == 0) return t('calc.interp.none');
  if (mods <= 4) return t('calc.interp.mild');
  if (mods <= 8) return t('calc.interp.moderate');
  if (mods <= 12) return t('calc.interp.severe');
  if (mods <= 16) return t('calc.interp.verySevere');
  if (mods <= 20) return t('calc.interp.extreme');
  return t('calc.interp.maximum');
}

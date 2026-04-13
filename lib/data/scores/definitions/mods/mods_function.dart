import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

ScoreResult modsFunction(Score score) {
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
      interpretation: 'Complete all six organ systems.',
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
      primaryLabel: 'MODS (partial)',
      primaryResult: '$total',
      primaryInterpretation: cardioIncomplete
          ? 'Enter HR, MAP, and CVP to score cardiovascular.'
          : 'Complete all six organ systems for full result.',
    );
  }

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'MODS',
    primaryResult: '$total / 24',
    primaryInterpretation: _interpret(total),
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

String _interpret(int mods) {
  if (mods == 0) return 'No dysfunction';
  if (mods <= 4) return 'Mild — MODS 1–4';
  if (mods <= 8) return 'Moderate — MODS 5–8';
  if (mods <= 12) return 'Severe — MODS 9–12';
  if (mods <= 16) return 'Very severe — MODS 13–16';
  return 'Maximum dysfunction — MODS > 16';
}

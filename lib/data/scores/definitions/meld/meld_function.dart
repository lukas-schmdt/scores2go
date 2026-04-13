import 'dart:math';

import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

ScoreResult meldFunction(Score score) {
  final ctx = FlatScoreContext(score: score);

  final bilirubinRaw = ctx.numValue('meld-bilirubin')?['value'] as num?;
  final inrRaw = ctx.numValue('meld-inr')?['value'] as num?;
  final creatinineRaw = ctx.numValue('meld-creatinine')?['value'] as num?;
  final dialysis = ctx.boolValue('meld-dialysis')?['value'] as bool?;

  if (bilirubinRaw == null && inrRaw == null && creatinineRaw == null) {
    return ScoreResult.incomplete(
      label: 'MELD',
      interpretation: 'Enter bilirubin, INR, and creatinine.',
    );
  }

  if (bilirubinRaw == null || inrRaw == null || creatinineRaw == null) {
    return ScoreResult.incomplete(
      label: 'MELD',
      interpretation: 'All three lab values are required.',
    );
  }

  // Apply MELD clamping rules
  final bilirubin = max(bilirubinRaw.toDouble(), 1.0);
  final inr = max(inrRaw.toDouble(), 1.0);
  // Dialysis ≥ 2×/week → creatinine fixed at 4.0
  final creatinine =
      (dialysis == true) ? 4.0 : min(max(creatinineRaw.toDouble(), 1.0), 4.0);

  // MELD = 3.78·ln(bilirubin) + 11.2·ln(INR) + 9.57·ln(creatinine) + 6.43
  final meld =
      3.78 * log(bilirubin) +
      11.2 * log(inr) +
      9.57 * log(creatinine) +
      6.43;

  final meldInt = meld.round().clamp(6, 40);

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'MELD',
    primaryResult: '$meldInt',
    primaryInterpretation: _interpret(meldInt),
    secondaryLabel: '90-day mortality',
    secondaryResult: _mortality(meldInt),
  );
}

String _interpret(int meld) {
  if (meld < 10) return 'Low — MELD < 10';
  if (meld < 20) return 'Moderate — MELD 10–19';
  if (meld < 30) return 'High — MELD 20–29';
  return 'Very high — MELD ≥ 30';
}

String _mortality(int meld) {
  if (meld <= 9) return '< 2 %';
  if (meld <= 19) return '6 %';
  if (meld <= 29) return '20 %';
  if (meld <= 39) return '52 %';
  return '> 71 %';
}

import 'dart:math';

import 'package:scores_2_go/data/scores/definitions/meld-3/meld_3_i10n.dart';
import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final _i10n = Meld3I10n();

ScoreResult meld3Function(Score score, String lang) {
  String t(String key) => _i10n.t(lang, key);
  final ctx = FlatScoreContext(score: score);

  final sexPts = ctx.singleSelect('meld3-sex')?['value'] as num?;
  final bilirubinRaw = ctx.numValue('meld3-bilirubin')?['value'] as num?;
  final inrRaw = ctx.numValue('meld3-inr')?['value'] as num?;
  final creatinineRaw = ctx.numValue('meld3-creatinine')?['value'] as num?;
  final sodiumRaw = ctx.numValue('meld3-sodium')?['value'] as num?;
  final albuminRaw = ctx.numValue('meld3-albumin')?['value'] as num?;
  // Unanswered dialysis is treated as "no dialysis" — it must never block
  // calculation.
  final dialysis = ctx.boolValue('meld3-dialysis')?['value'] as bool?;

  final allRequiredPresent =
      sexPts != null &&
      bilirubinRaw != null &&
      inrRaw != null &&
      creatinineRaw != null &&
      sodiumRaw != null &&
      albuminRaw != null;

  if (!allRequiredPresent) {
    return ScoreResult.incomplete(
      label: t('display'),
      interpretation: t('calc.incomplete.allRequired'),
    );
  }

  // Guard against physiologically impossible entries (≤ 0) before they can
  // reach ln() or the (3.5 − albumin) term. The MELD 3.0 clamps below only
  // bound values from *above* on the low end (floors), they do not protect
  // against nonsense negative/zero lab entries, so this must be checked
  // separately.
  if (bilirubinRaw <= 0 || inrRaw <= 0 || creatinineRaw <= 0 || albuminRaw <= 0) {
    return ScoreResult(
      state: ScoreState.error,
      primaryLabel: t('display'),
      primaryResult: '—',
      primaryInterpretation: t('calc.error.impossibleValues'),
    );
  }

  // ─── Clamp each input per Kim et al. 2021 (MELD 3.0) ─────────────────────
  final bilirubin = max(bilirubinRaw.toDouble(), 1.0);
  final inr = max(inrRaw.toDouble(), 1.0);
  final sodium = min(max(sodiumRaw.toDouble(), 125.0), 137.0);
  final albumin = min(max(albuminRaw.toDouble(), 1.5), 3.5);
  // Dialysis (≥2 sessions in the prior week, or ≥24 h CVVHD) forces
  // creatinine to 3.0 — note this is 3.0, NOT the original MELD's 4.0.
  final creatinine = (dialysis == true)
      ? 3.0
      : min(max(creatinineRaw.toDouble(), 1.0), 3.0);

  final isFemale = sexPts.round() == 1;

  // ─── MELD 3.0 formula (Kim WR, Mannalithara A, Heimbach JK, et al. 2021) ─
  final sexTerm = isFemale ? 1.33 : 0.0;
  final bilirubinTerm = 4.56 * log(bilirubin);
  final sodiumTerm = 0.82 * (137 - sodium);
  // Sodium × bilirubin interaction term.
  final sodiumBilirubinInteraction = -0.24 * (137 - sodium) * log(bilirubin);
  final inrTerm = 9.09 * log(inr);
  final creatinineTerm = 11.14 * log(creatinine);
  final albuminTerm = 1.85 * (3.5 - albumin);
  // Albumin × creatinine interaction term.
  final albuminCreatinineInteraction =
      -1.83 * (3.5 - albumin) * log(creatinine);

  final raw =
      sexTerm +
      bilirubinTerm +
      sodiumTerm +
      sodiumBilirubinInteraction +
      inrTerm +
      creatinineTerm +
      albuminTerm +
      albuminCreatinineInteraction +
      6;

  final meldInt = raw.round().clamp(6, 40);

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: t('display'),
    primaryResult: '$meldInt',
    primaryInterpretation: _interpret(meldInt, t),
    secondaryLabel: t('calc.mortality90day'),
    secondaryResult: _mortality(meldInt),
  );
}

String _interpret(int meld, String Function(String) t) {
  if (meld < 10) return t('calc.risk.low');
  if (meld < 20) return t('calc.risk.moderate');
  if (meld < 30) return t('calc.risk.high');
  return t('calc.risk.veryHigh');
}

/// 90-day mortality by MELD 3.0 band (Wiesner et al. 2003).
String _mortality(int meld) {
  if (meld <= 9) return '1.9 %';
  if (meld <= 19) return '6.0 %';
  if (meld <= 29) return '19.6 %';
  if (meld <= 39) return '52.6 %';
  return '71.3 %';
}

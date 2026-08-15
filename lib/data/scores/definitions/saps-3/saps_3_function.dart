import 'dart:math';

import 'package:scores_2_go/data/scores/definitions/saps-3/saps_3_i10n.dart';
import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final _i10n = Saps3I10n();

ScoreResult saps3Function(Score score, String lang) {
  String t(String key) => _i10n.t(lang, key);
  final ctx = FlatScoreContext(score: score);

  // Box I
  final agePts     = ctx.singleSelect('saps3-age')?['value']           as num?;
  final comorbs    = ctx.multiSelect('saps3-comorbidities');
  final ventilated = ctx.boolValue('saps3-ventilated')?['value']       as bool?;

  // Box II
  final locationPts = ctx.singleSelect('saps3-location')?['value']     as num?;
  final surgical    = ctx.boolValue('saps3-surgical')?['value']        as bool?;
  final reasonPts   = ctx.singleSelect('saps3-reason')?['value']       as num?;

  // Box III
  final gcsPts      = ctx.singleSelect('saps3-gcs')?['value']         as num?;
  final bilPts      = ctx.singleSelect('saps3-bilirubin')?['value']   as num?;
  final tempPts     = ctx.singleSelect('saps3-temperature')?['value'] as num?;
  final hrPts       = ctx.singleSelect('saps3-heart_rate')?['value']  as num?;
  final mapPts      = ctx.singleSelect('saps3-map')?['value']         as num?;
  final creatPts    = ctx.singleSelect('saps3-creatinine')?['value']  as num?;
  final pltPts      = ctx.singleSelect('saps3-platelets')?['value']   as num?;
  final wbcPts      = ctx.singleSelect('saps3-wbc')?['value']         as num?;
  final phPts       = ctx.singleSelect('saps3-ph')?['value']          as num?;
  final pao2Pts     = ctx.singleSelect('saps3-pao2_fio2')?['value']   as num?;

  final isVentilated = ventilated ?? false;
  final oxyComplete = ventilated != null && (!isVentilated || pao2Pts != null);

  // comorbs may be null/empty = no comorbidities selected = 0 points (valid)
  final allComplete =
      agePts != null &&
      ventilated != null &&
      locationPts != null &&
      surgical != null &&
      reasonPts != null &&
      gcsPts != null &&
      bilPts != null &&
      tempPts != null &&
      hrPts != null &&
      mapPts != null &&
      creatPts != null &&
      pltPts != null &&
      wbcPts != null &&
      phPts != null &&
      oxyComplete;

  if (!allComplete) {
    return ScoreResult.incomplete(
      label: 'SAPS 3',
      interpretation: t('calc.incomplete'),
    );
  }

  // Comorbidity points — each selected item is an independent binary
  // criterion in the original instrument (confirmed against MDCalc's
  // "independent checkboxes" framing), so they are summed, not hierarchical.
  final comorbValues = (comorbs ?? []).map((e) => (e['value'] as num).toInt());
  final comorbTotal = comorbValues.fold(0, (a, b) => a + b);

  final surgicalPts = (surgical == true) ? -6 : 0;
  final oxyPts = isVentilated ? pao2Pts!.round() : 0;
  final ventPts = isVentilated ? 9 : 0;

  final total = agePts.round() +
      comorbTotal +
      locationPts.round() +
      surgicalPts +
      reasonPts.round() +
      gcsPts.round() +
      bilPts.round() +
      tempPts.round() +
      hrPts.round() +
      mapPts.round() +
      creatPts.round() +
      pltPts.round() +
      wbcPts.round() +
      phPts.round() +
      oxyPts +
      ventPts;

  final mortality = _predictedMortality(total);
  final mortalityPct = (mortality * 100).toStringAsFixed(1);

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'SAPS 3 Score',
    primaryResult: '$total ${t('calc.points')}',
    primaryInterpretation:
        '${t('calc.estimatedHospitalMortality')}: $mortalityPct %',
    secondaryLabel: t('calc.riskClass'),
    secondaryResult: _riskClass(mortality, t),
  );
}

/// Global (pooled, non-region-customized) equation from Moreno et al. 2005
/// Part 2: logit = -32.6659 + ln(SAPS3 + 20.5958) × 7.3068. The prior
/// intercept (-36.0757) was a transcription error that systematically
/// under-predicted mortality for every score.
double _predictedMortality(int saps3) {
  final logit = -32.6659 + log(saps3 + 20.5958) * 7.3068;
  return exp(logit) / (1 + exp(logit));
}

String _riskClass(double mortality, String Function(String) t) {
  if (mortality < 0.10) return t('calc.risk.low');
  if (mortality < 0.25) return t('calc.risk.moderate');
  if (mortality < 0.50) return t('calc.risk.high');
  return t('calc.risk.veryHigh');
}

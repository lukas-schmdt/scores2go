import 'package:scores_2_go/data/scores/definitions/apache-ii/apache_ii_i10n.dart';
import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final _i10n = ApacheIiI10n();

ScoreResult apacheIiFunction(Score score, String lang) {
  String t(String key) => _i10n.t(lang, key);
  final ctx = FlatScoreContext(score: score);

  final tempPts    = ctx.singleSelect('apache-ii-temperatur')?['value']    as num?;
  final mapPts     = ctx.singleSelect('apache-ii-map')?['value']           as num?;
  final hrPts      = ctx.singleSelect('apache-ii-herzfrequenz')?['value']  as num?;
  final rrPts      = ctx.singleSelect('apache-ii-atemfrequenz')?['value']  as num?;
  final fio2High   = ctx.boolValue('apache-ii-fio2_hoch')?['value']        as bool?;
  final aaDo2Pts   = ctx.singleSelect('apache-ii-aado2')?['value']         as num?;
  final paO2Pts    = ctx.singleSelect('apache-ii-pao2')?['value']          as num?;
  final phPts      = ctx.singleSelect('apache-ii-ph_arteriell')?['value']  as num?;
  final naPts      = ctx.singleSelect('apache-ii-natrium')?['value']       as num?;
  final kPts       = ctx.singleSelect('apache-ii-kalium')?['value']        as num?;
  final creatPts   = ctx.singleSelect('apache-ii-kreatinin')?['value']     as num?;
  final arf        = ctx.boolValue('apache-ii-arf')?['value']              as bool?;
  final hctPts     = ctx.singleSelect('apache-ii-haematokrit')?['value']   as num?;
  final wbcPts     = ctx.singleSelect('apache-ii-leukozyten')?['value']    as num?;
  final gcs        = ctx.numValue('apache-ii-gcs')?['value']               as num?;
  final agePts     = ctx.singleSelect('apache-ii-alter')?['value']         as num?;
  final chronicPts = ctx.singleSelect('apache-ii-vorerkrankungen')?['value'] as num?;

  final oxyComplete =
      fio2High != null && (fio2High ? aaDo2Pts != null : paO2Pts != null);

  final allComplete =
      tempPts != null &&
      mapPts != null &&
      hrPts != null &&
      rrPts != null &&
      oxyComplete &&
      phPts != null &&
      naPts != null &&
      kPts != null &&
      creatPts != null &&
      arf != null &&
      hctPts != null &&
      wbcPts != null &&
      gcs != null &&
      agePts != null &&
      chronicPts != null;

  if (!allComplete) {
    return ScoreResult.incomplete(
      label: 'APACHE II',
      interpretation: t('calc.incomplete'),
    );
  }

  // ── Acute Physiology Score (APS) ─────────────────────────────────────────
  final apsOxy   = fio2High ? aaDo2Pts!.round() : paO2Pts!.round();
  final apsCreat = (arf == true) ? creatPts.round() * 2 : creatPts.round();
  final apsGcs   = (15 - gcs.round()).clamp(0, 12);

  final aps =
      tempPts.round() +
      mapPts.round() +
      hrPts.round() +
      rrPts.round() +
      apsOxy +
      phPts.round() +
      naPts.round() +
      kPts.round() +
      apsCreat +
      hctPts.round() +
      wbcPts.round() +
      apsGcs;

  final agePtsInt  = agePts.round();
  final chronic    = chronicPts.round();
  final total      = aps + agePtsInt + chronic;

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'APACHE II Score',
    primaryResult: '$total ${t('calc.points')}',
    primaryInterpretation: _mortalityRisk(total, t),
    secondaryLabel: t('calc.subscoresLabel'),
    secondaryResult:
        'APS $aps  |  ${t('calc.subscoresAge')} $agePtsInt  |  '
        '${t('calc.subscoresChronic')} $chronic',
    secondaryInterpretation: t('calc.approxNote'),
  );
}

/// Diagnosis-independent illustrative reference range only. The validated
/// Knaus mortality equation — Ln(R/1-R) = -3.517 + 0.146×score + 0.603 (if
/// emergency surgery) + diagnostic-category weight — also requires the
/// admission diagnosis and emergency-surgery status, neither of which is
/// collected here, so it cannot be computed from the point total alone.
/// Knaus WA, Draper EA, Wagner DP, Zimmerman JE. Crit Care Med. 1985;13(10):818-829.
String _mortalityRisk(int total, String Function(String) t) {
  if (total < 5) return t('calc.risk.veryLow');
  if (total < 10) return t('calc.risk.low');
  if (total < 15) return t('calc.risk.moderate');
  if (total < 20) return t('calc.risk.elevated');
  if (total < 25) return t('calc.risk.high');
  if (total < 30) return t('calc.risk.veryHigh');
  if (total < 35) return t('calc.risk.critical');
  return t('calc.risk.extremelyCritical');
}

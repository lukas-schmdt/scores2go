import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

ScoreResult apacheIiFunction(Score score) {
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
      interpretation: 'Bitte alle Pflichtfelder ausfüllen.',
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
    primaryResult: '$total Punkte',
    primaryInterpretation: _mortalityRisk(total),
    secondaryLabel: 'Teilscores',
    secondaryResult:
        'APS $aps  |  Alter $agePtsInt  |  Vorerkrankungen $chronic',
  );
}

String _mortalityRisk(int total) {
  if (total < 5)  return 'Sehr niedriges Risiko (~2 % Krankenhausmortalität)';
  if (total < 10) return 'Niedriges Risiko (~8 % Krankenhausmortalität)';
  if (total < 15) return 'Moderates Risiko (~15 % Krankenhausmortalität)';
  if (total < 20) return 'Erhöhtes Risiko (~24 % Krankenhausmortalität)';
  if (total < 25) return 'Hohes Risiko (~40 % Krankenhausmortalität)';
  if (total < 30) return 'Sehr hohes Risiko (~55 % Krankenhausmortalität)';
  if (total < 35) return 'Kritisch (~73 % Krankenhausmortalität)';
  return 'Extrem kritisch (~85 % Krankenhausmortalität)';
}

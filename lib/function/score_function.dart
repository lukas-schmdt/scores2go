import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

// ─── Demo Score ───────────────────────────────────────────────────────────────
ScoreResult demoMain(Score score) {
  final ctx = FlatScoreContext(score: score);

  final o2 = ctx.boolValue(1);
  final alert = ctx.singleSelectValueId(3);
  if (o2 == null || alert == null) return ScoreResult.incomplete();

  final vented = ctx.boolValue(4);
  final isVented = (vented?['value'] as bool?) ?? false;
  final fio2 = ctx.singleSelectValueId(5);
  if (isVented && fio2 == null) return ScoreResult.incomplete();

  final temp = ctx.numValue(2);
  final comor = ctx.multiSelectValueIds(6) ?? [];
  final sugar = ctx.singleSelectValueId(7);

  final o2Pts = (o2['points'] as num).toInt();
  final alertPts = (alert['value'] as num).toInt();
  final fio2Pts = isVented ? (fio2!['value'] as num).toInt() : 0;
  final comorPts = comor.fold<int>(
    0,
    (s, c) => s + (c['value'] as num).toInt(),
  );
  final sugarPts = sugar != null ? (sugar['value'] as num).toInt() : 0;
  final total = o2Pts + alertPts + fio2Pts + comorPts + sugarPts;

  final tempAnnotation = temp != null
      ? ' | Temp: ${(temp['value'] as num).toStringAsFixed(1)} °C'
      : '';

  String riskLabel(int t) {
    if (t <= 2) return 'Low';
    if (t <= 5) return 'Medium';
    return 'High';
  }

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'Demo Score Total',
    primaryResult: '$total pts',
    primaryInterpretation:
        'O₂:$o2Pts  |  Alertness:$alertPts'
        '${isVented ? '  |  FiO₂:$fio2Pts' : ''}  |  Comorbid.:$comorPts',
    secondaryLabel: 'Risk Level',
    secondaryResult: riskLabel(total),
    secondaryInterpretation:
        'Score ≤2 → Low | 3–5 → Medium | ≥6 → High$tempAnnotation',
  );
}

ScoreResult apache2Main(Score score) {
  final ctx = FlatScoreContext(score: score);

  // Selection variables — value field = the APACHE II subscore for that band.
  final tempPts  = ctx.singleSelectValueId(1)?['value']  as num?;
  final mapPts   = ctx.singleSelectValueId(2)?['value']  as num?;
  final hrPts    = ctx.singleSelectValueId(3)?['value']  as num?;
  final rrPts    = ctx.singleSelectValueId(4)?['value']  as num?;
  final fio2High = ctx.boolValue(5)?['value']            as bool?;
  final aaDo2Pts = ctx.singleSelectValueId(6)?['value']  as num?;
  final paO2Pts  = ctx.singleSelectValueId(7)?['value']  as num?;
  final phPts    = ctx.singleSelectValueId(8)?['value']  as num?;
  final naPts    = ctx.singleSelectValueId(9)?['value']  as num?;
  final kPts     = ctx.singleSelectValueId(10)?['value'] as num?;
  final creatPts = ctx.singleSelectValueId(11)?['value'] as num?;
  final arf      = ctx.boolValue(12)?['value']           as bool?;
  final hctPts   = ctx.singleSelectValueId(13)?['value'] as num?;
  final wbcPts   = ctx.singleSelectValueId(14)?['value'] as num?;
  final gcs      = ctx.numValue(15)?['value']            as num?; // still VariableNumber
  final agePts   = ctx.singleSelectValueId(16)?['value'] as num?;
  final chronicPts = ctx.singleSelectValueId(17)?['value'] as num?;

  // Oxygenation: need FiO₂ decision + the corresponding measurement selected.
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

  // ── Age + Chronic Health ──────────────────────────────────────────────────
  final agePtsInt = agePts.round();
  final chronic   = chronicPts.round();

  final total = aps + agePtsInt + chronic;

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'APACHE II Score',
    primaryResult: '$total Punkte',
    primaryInterpretation: _mortalityRisk(total),
    secondaryLabel: 'Teilscores',
    secondaryResult: 'APS $aps  |  Alter $agePtsInt  |  Vorerkrankungen $chronic',
  );
}

// ─── Mortality risk ───────────────────────────────────────────────────────────

String _mortalityRisk(int total) {
  if (total < 5) return 'Sehr niedriges Risiko (~2 % Krankenhausmortalität)';
  if (total < 10) return 'Niedriges Risiko (~8 % Krankenhausmortalität)';
  if (total < 15) return 'Moderates Risiko (~15 % Krankenhausmortalität)';
  if (total < 20) return 'Erhöhtes Risiko (~24 % Krankenhausmortalität)';
  if (total < 25) return 'Hohes Risiko (~40 % Krankenhausmortalität)';
  if (total < 30) return 'Sehr hohes Risiko (~55 % Krankenhausmortalität)';
  if (total < 35) return 'Kritisch (~73 % Krankenhausmortalität)';
  return 'Extrem kritisch (~85 % Krankenhausmortalität)';
}

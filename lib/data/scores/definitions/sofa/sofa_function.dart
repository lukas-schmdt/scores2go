import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

ScoreResult sofaFunction(Score score) {
  final ctx = FlatScoreContext(score: score);

  final respirPts = ctx.singleSelect('sofa-pao2_fio2')?['value']              as num?;
  final coagPts   = ctx.singleSelect('sofa-platelets')?['value']              as num?;
  final liverPts  = ctx.singleSelect('sofa-bilirubin')?['value']              as num?;
  final cardPts   = ctx.singleSelect('sofa-cardiovascular_status')?['value']  as num?;
  final cnsPts    = ctx.singleSelect('sofa-gcs')?['value']                    as num?;
  final creatPts  = ctx.singleSelect('sofa-creatinine')?['value']             as num?;
  final urinePts  = ctx.singleSelect('sofa-urine_output')?['value']           as num?;

  final allComplete =
      respirPts != null &&
      coagPts != null &&
      liverPts != null &&
      cardPts != null &&
      cnsPts != null &&
      (creatPts != null || urinePts != null);

  if (!allComplete) {
    return ScoreResult.incomplete(
      label: 'SOFA',
      interpretation: 'Bitte alle Pflichtfelder ausfüllen (Niere: Kreatinin oder Urin).',
    );
  }

  // Renal score: worst of creatinine vs urine output
  final renalPts = [
    creatPts?.round() ?? 0,
    urinePts?.round() ?? 0,
  ].reduce((a, b) => a > b ? a : b);

  final total =
      respirPts.round() +
      coagPts.round() +
      liverPts.round() +
      cardPts.round() +
      cnsPts.round() +
      renalPts;

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'SOFA Score',
    primaryResult: '$total Punkte',
    primaryInterpretation: _mortalityRisk(total),
    secondaryLabel: 'Organsysteme',
    secondaryResult:
        'Resp ${respirPts.round()}  |  Koag ${coagPts.round()}  |  '
        'Leber ${liverPts.round()}  |  Kardio ${cardPts.round()}  |  '
        'ZNS ${cnsPts.round()}  |  Niere $renalPts',
  );
}

String _mortalityRisk(int total) {
  if (total < 2)  return 'Sehr geringes Risiko (< 10 % Mortalität)';
  if (total < 4)  return 'Geringes Risiko (~10 % Mortalität)';
  if (total < 8)  return 'Moderates Risiko (~20 % Mortalität)';
  if (total < 12) return 'Erhöhtes Risiko (~40 % Mortalität)';
  return 'Hohes Risiko (> 50 % Mortalität)';
}

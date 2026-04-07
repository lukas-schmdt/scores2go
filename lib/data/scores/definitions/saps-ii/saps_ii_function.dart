import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

ScoreResult sapsIiFunction(Score score) {
  final ctx = FlatScoreContext(score: score);

  final alterPts      = ctx.singleSelect('saps-ii-alter')?['value']                   as num?;
  final aufnahmePts   = ctx.singleSelect('saps-ii-aufnahmeart')?['value']             as num?;
  final chronicPts    = ctx.singleSelect('saps-ii-chronische_erkrankungen')?['value'] as num?;
  final hrPts         = ctx.singleSelect('saps-ii-herzfrequenz')?['value']            as num?;
  final sbpPts        = ctx.singleSelect('saps-ii-systolischer_blutdruck')?['value']  as num?;
  final tempPts       = ctx.singleSelect('saps-ii-temperatur')?['value']              as num?;
  final gcsPts        = ctx.singleSelect('saps-ii-gcs')?['value']                     as num?;
  final ventilated    = ctx.boolValue('saps-ii-beatmet_oder_cpap')?['value']          as bool?;
  final pao2Pts       = ctx.singleSelect('saps-ii-pao2_fio2')?['value']              as num?;
  final urinePts      = ctx.singleSelect('saps-ii-urinausscheidung')?['value']        as num?;
  final bunPts        = ctx.singleSelect('saps-ii-bun')?['value']                     as num?;
  final wbcPts        = ctx.singleSelect('saps-ii-leukozyten')?['value']              as num?;
  final kPts          = ctx.singleSelect('saps-ii-kalium')?['value']                  as num?;
  final naPts         = ctx.singleSelect('saps-ii-natrium')?['value']                 as num?;
  final bicarbPts     = ctx.singleSelect('saps-ii-bicarbonat')?['value']              as num?;
  final bilirubinPts  = ctx.singleSelect('saps-ii-bilirubin')?['value']               as num?;

  // PaO₂/FiO₂ is only required when ventilated
  final isVentilated = ventilated ?? false;
  final oxyComplete = ventilated != null && (!isVentilated || pao2Pts != null);

  final allComplete =
      alterPts != null &&
      aufnahmePts != null &&
      chronicPts != null &&
      hrPts != null &&
      sbpPts != null &&
      tempPts != null &&
      gcsPts != null &&
      oxyComplete &&
      urinePts != null &&
      bunPts != null &&
      wbcPts != null &&
      kPts != null &&
      naPts != null &&
      bicarbPts != null &&
      bilirubinPts != null;

  if (!allComplete) {
    return ScoreResult.incomplete(
      label: 'SAPS II',
      interpretation: 'Bitte alle Pflichtfelder ausfüllen.',
    );
  }

  final oxyPts = isVentilated ? pao2Pts!.round() : 0;

  final total =
      alterPts.round() +
      aufnahmePts.round() +
      chronicPts.round() +
      hrPts.round() +
      sbpPts.round() +
      tempPts.round() +
      gcsPts.round() +
      oxyPts +
      urinePts.round() +
      bunPts.round() +
      wbcPts.round() +
      kPts.round() +
      naPts.round() +
      bicarbPts.round() +
      bilirubinPts.round();

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'SAPS II Score',
    primaryResult: '$total Punkte',
    primaryInterpretation: _mortalityRisk(total),
    secondaryLabel: 'Hinweis',
    secondaryResult: 'Krankenhausmortalität (geschätzt)',
    secondaryInterpretation:
        'SAPS II ≥ 50 ist mit einer Mortalität > 50 % assoziiert.',
  );
}

String _mortalityRisk(int total) {
  if (total < 30) return 'Niedriges Risiko (< 10 % Krankenhausmortalität)';
  if (total < 40) return 'Moderates Risiko (~15 % Krankenhausmortalität)';
  if (total < 50) return 'Erhöhtes Risiko (~25 % Krankenhausmortalität)';
  if (total < 60) return 'Hohes Risiko (~40 % Krankenhausmortalität)';
  if (total < 70) return 'Sehr hohes Risiko (~60 % Krankenhausmortalität)';
  return 'Kritisch (> 80 % Krankenhausmortalität)';
}

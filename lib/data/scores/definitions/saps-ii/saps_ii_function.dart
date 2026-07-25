import 'package:scores_2_go/data/scores/definitions/saps-ii/saps_ii_i10n.dart';
import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final _i10n = SapsIiI10n();

ScoreResult sapsIiFunction(Score score, String lang) {
  String t(String key) => _i10n.t(lang, key);
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
      interpretation: t('calc.incomplete'),
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
    primaryResult: '$total ${t('calc.points')}',
    primaryInterpretation: _mortalityRisk(total, t),
    secondaryLabel: t('calc.note'),
    secondaryResult: t('calc.hospitalMortalityEstimated'),
    secondaryInterpretation: t('calc.highScoreNote'),
  );
}

String _mortalityRisk(int total, String Function(String) t) {
  if (total < 30) return t('calc.risk.low');
  if (total < 40) return t('calc.risk.moderate');
  if (total < 50) return t('calc.risk.elevated');
  if (total < 60) return t('calc.risk.high');
  if (total < 70) return t('calc.risk.veryHigh');
  return t('calc.risk.critical');
}

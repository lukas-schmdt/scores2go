import 'package:scores_2_go/data/scores/definitions/sofa/sofa_i10n.dart';
import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final _i10n = SofaI10n();

ScoreResult sofaFunction(Score score, String lang) {
  String t(String key) => _i10n.t(lang, key);
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
      interpretation: t('calc.incomplete'),
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
    primaryResult: '$total ${t('calc.points')}',
    primaryInterpretation: _mortalityRisk(total, t),
    secondaryLabel: t('calc.organSystems'),
    secondaryResult:
        '${t('calc.abbrev.resp')} ${respirPts.round()}  |  '
        '${t('calc.abbrev.coag')} ${coagPts.round()}  |  '
        '${t('calc.abbrev.liver')} ${liverPts.round()}  |  '
        '${t('calc.abbrev.cardio')} ${cardPts.round()}  |  '
        '${t('calc.abbrev.cns')} ${cnsPts.round()}  |  '
        '${t('calc.abbrev.renal')} $renalPts',
  );
}

String _mortalityRisk(int total, String Function(String) t) {
  if (total < 2) return t('calc.risk.veryLow');
  if (total < 4) return t('calc.risk.low');
  if (total < 8) return t('calc.risk.moderate');
  if (total < 12) return t('calc.risk.elevated');
  return t('calc.risk.high');
}

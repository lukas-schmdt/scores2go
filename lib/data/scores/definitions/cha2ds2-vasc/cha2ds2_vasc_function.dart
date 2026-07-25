import 'package:scores_2_go/data/scores/definitions/cha2ds2-vasc/cha2ds2_vasc_i10n.dart';
import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final _i10n = Cha2ds2VascI10n();

ScoreResult cha2ds2VascFunction(Score score, String lang) {
  String t(String key) => _i10n.t(lang, key);
  final ctx = FlatScoreContext(score: score);

  final chfPts = ctx.boolValue('cha2ds2-vasc-chf')?['points'] as num?;
  final hypertensionPts =
      ctx.boolValue('cha2ds2-vasc-hypertension')?['points'] as num?;
  final agePts = ctx.singleSelect('cha2ds2-vasc-age')?['value'] as num?;
  final diabetesPts =
      ctx.boolValue('cha2ds2-vasc-diabetes')?['points'] as num?;
  final strokeTiaPts =
      ctx.boolValue('cha2ds2-vasc-stroke-tia')?['points'] as num?;
  final vascularPts =
      ctx.boolValue('cha2ds2-vasc-vascular-disease')?['points'] as num?;
  final sexPts = ctx.singleSelect('cha2ds2-vasc-sex')?['value'] as num?;

  final allComplete =
      chfPts != null &&
      hypertensionPts != null &&
      agePts != null &&
      diabetesPts != null &&
      strokeTiaPts != null &&
      vascularPts != null &&
      sexPts != null;

  if (!allComplete) {
    return ScoreResult.incomplete(
      label: 'CHA2DS2-VASc Score',
      interpretation: t('calc.incomplete'),
    );
  }

  final total =
      chfPts.round() +
      hypertensionPts.round() +
      agePts.round() +
      diabetesPts.round() +
      strokeTiaPts.round() +
      vascularPts.round() +
      sexPts.round();

  // sex option value: 1 = female, 0 = male
  final isFemale = sexPts.round() == 1;

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'CHA2DS2-VASc Score',
    primaryResult: '$total / 9',
    primaryInterpretation: _anticoagulationGuidance(total, isFemale, t),
    secondaryLabel: t('calc.secondaryLabel'),
    secondaryResult: '${_strokeRisk(total)}% per year',
    secondaryInterpretation: t('calc.citation'),
  );
}

/// Annual ischemic stroke risk (%) by total CHA2DS2-VASc score,
/// from Friberg L, Rosenqvist M, Lip GYH. Eur Heart J. 2012;33(12):1500-1510.
const _strokeRiskByScore = [
  0.2, // 0
  0.6, // 1
  2.2, // 2
  3.2, // 3
  4.8, // 4
  7.2, // 5
  9.7, // 6
  11.2, // 7
  10.8, // 8
  12.2, // 9
];

double _strokeRisk(int total) => _strokeRiskByScore[total];

String _anticoagulationGuidance(
  int total,
  bool isFemale,
  String Function(String) t,
) {
  final threshold = isFemale ? total >= 3 : total >= 2;
  final consider = isFemale ? total == 2 : total == 1;

  final suffix = (isFemale
          ? t('calc.scoreSuffix.female')
          : t('calc.scoreSuffix.male'))
      .replaceFirst('{n}', '$total');

  if (threshold) {
    return '${t('calc.guidance.threshold')}$suffix';
  }
  if (consider) {
    return '${t('calc.guidance.consider')}$suffix';
  }
  return '${t('calc.guidance.none')}$suffix';
}

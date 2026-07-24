import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

ScoreResult cha2ds2VascFunction(Score score) {
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
      interpretation: 'Please answer all risk factors.',
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
    primaryInterpretation: _anticoagulationGuidance(total, isFemale),
    secondaryLabel: 'Annual Stroke Risk',
    secondaryResult: '${_strokeRisk(total)}% per year',
    secondaryInterpretation:
        'Based on the Friberg et al. 2012 Swedish Atlas cohort (n=182,678).',
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

String _anticoagulationGuidance(int total, bool isFemale) {
  final threshold = isFemale ? total >= 3 : total >= 2;
  final consider = isFemale ? total == 2 : total == 1;

  if (threshold) {
    return 'Oral anticoagulation is recommended (ESC 2020) — '
        'score $total in a ${isFemale ? 'woman' : 'man'}.';
  }
  if (consider) {
    return 'Oral anticoagulation may be considered — individualize based on '
        'patient preference and bleeding risk (ESC 2020) — score $total in a '
        '${isFemale ? 'woman' : 'man'}.';
  }
  return 'No antithrombotic therapy is needed based on stroke risk alone — '
      'score $total in a ${isFemale ? 'woman' : 'man'}.';
}

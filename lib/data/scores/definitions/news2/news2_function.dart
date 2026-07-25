import 'package:scores_2_go/data/scores/definitions/news2/news2_i10n.dart';
import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final _i10n = News2I10n();

ScoreResult news2Function(Score score, String lang) {
  String t(String key) => _i10n.t(lang, key);
  final ctx = FlatScoreContext(score: score);

  final rrPts           = ctx.singleSelect('news2-rr')?['value']             as num?;
  final isHypercapnic   = ctx.boolValue('news2-hypercapnic')?['value']       as bool?;
  final spo2Scale1Pts   = ctx.singleSelect('news2-spo2-1')?['value']         as num?;
  final spo2Scale2Pts   = ctx.singleSelect('news2-spo2-2')?['value']         as num?;
  final o2Pts           = ctx.boolValue('news2-o2')?['points']               as num?;
  final sbpPts          = ctx.singleSelect('news2-sbp')?['value']            as num?;
  final pulsePts        = ctx.singleSelect('news2-pulse')?['value']          as num?;
  final consciousnessPts= ctx.singleSelect('news2-consciousness')?['value']  as num?;
  final tempPts         = ctx.singleSelect('news2-temp')?['value']           as num?;

  final spo2Pts = isHypercapnic == null
      ? null
      : isHypercapnic
          ? spo2Scale2Pts
          : spo2Scale1Pts;

  final allComplete =
      rrPts != null &&
      isHypercapnic != null &&
      spo2Pts != null &&
      o2Pts != null &&
      sbpPts != null &&
      pulsePts != null &&
      consciousnessPts != null &&
      tempPts != null;

  if (!allComplete) {
    return ScoreResult.incomplete(
      label: 'NEWS2',
      interpretation: t('calc.incomplete'),
    );
  }

  final total =
      (rrPts + spo2Pts + o2Pts + sbpPts + pulsePts + consciousnessPts + tempPts)
          .round();

  // Detect whether any single scored physiological parameter reaches 3
  // (triggers medium clinical risk even if total < 5).
  final maxSingleParam = [rrPts, spo2Pts, sbpPts, pulsePts, consciousnessPts, tempPts]
      .map((v) => v.round())
      .reduce((a, b) => a > b ? a : b);

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'NEWS2',
    primaryResult: '$total ${t('calc.pointsResult')}',
    primaryInterpretation: _clinicalRisk(total, maxSingleParam, t),
    secondaryLabel: t('calc.recommendationLabel'),
    secondaryResult: _recommendation(total, maxSingleParam, t),
  );
}

String _clinicalRisk(int total, int maxSingle, String Function(String) t) {
  if (total >= 7) return t('calc.risk.high');
  if (total >= 5) return t('calc.risk.mediumUrgent');
  if (maxSingle >= 3) return t('calc.risk.mediumSingleParam');
  if (total >= 1) return t('calc.risk.low');
  return t('calc.risk.minimal');
}

String _recommendation(int total, int maxSingle, String Function(String) t) {
  if (total >= 7) return t('calc.rec.high');
  if (total >= 5) return t('calc.rec.mediumUrgent');
  if (maxSingle >= 3) return t('calc.rec.mediumSingleParam');
  if (total >= 1) return t('calc.rec.low');
  return t('calc.rec.minimal');
}

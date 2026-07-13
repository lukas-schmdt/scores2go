import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

ScoreResult news2Function(Score score) {
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
      interpretation: 'Bitte alle Pflichtfelder ausfüllen.',
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
    primaryResult: '$total Punkte',
    primaryInterpretation: _clinicalRisk(total, maxSingleParam),
    secondaryLabel: 'Empfehlung',
    secondaryResult: _recommendation(total, maxSingleParam),
  );
}

String _clinicalRisk(int total, int maxSingle) {
  if (total >= 7) return 'Hohes Risiko — Notfallreaktion';
  if (total >= 5) return 'Mittleres Risiko — Dringende Beurteilung';
  if (maxSingle >= 3) return 'Mittleres Risiko — Einzelparameter kritisch';
  if (total >= 1) return 'Niedriges Risiko';
  return 'Minimales Risiko';
}

String _recommendation(int total, int maxSingle) {
  if (total >= 7) return 'Kontinuierliches Monitoring · Intensivaufnahme erwägen';
  if (total >= 5) return 'Monitoring mind. stündlich · Arzt sofort informieren';
  if (maxSingle >= 3) return 'Monitoring mind. stündlich · Arzt informieren';
  if (total >= 1) return 'Monitoring 4–6-stündlich';
  return 'Monitoring 12-stündlich';
}

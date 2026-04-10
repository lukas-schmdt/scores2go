import 'dart:math';

import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

// EuroSCORE II logistic regression coefficients (Nashef et al. 2012)
// logit = -5.324537 + sum(coefficient × value)
// predicted mortality = e^logit / (1 + e^logit)

ScoreResult euroscoreFunction(Score score) {
  final ctx = FlatScoreContext(score: score);

  final age = ctx.numValue('euroscore-age')?['value'] as num?;
  final female = ctx.boolValue('euroscore-female')?['value'] as bool?;
  final creatHigh =
      ctx.boolValue('euroscore-creatinine_high')?['value'] as bool?;
  final arterio = ctx.boolValue('euroscore-arteriopathy')?['value'] as bool?;
  final poorMob = ctx.boolValue('euroscore-poor_mobility')?['value'] as bool?;
  final prevSurg = ctx.boolValue('euroscore-prev_surgery')?['value'] as bool?;
  final copd = ctx.boolValue('euroscore-copd')?['value'] as bool?;
  final endocard = ctx.boolValue('euroscore-endocarditis')?['value'] as bool?;
  final critical = ctx.boolValue('euroscore-critical_state')?['value'] as bool?;
  final diabInsulin =
      ctx.boolValue('euroscore-diabetes_insulin')?['value'] as bool?;
  final nyhaPts = ctx.singleSelect('euroscore-nyha')?['value'] as num?;
  final ccs4 = ctx.boolValue('euroscore-ccs4')?['value'] as bool?;
  final lvPts = ctx.singleSelect('euroscore-lv_function')?['value'] as num?;
  final recentMi = ctx.boolValue('euroscore-recent_mi')?['value'] as bool?;
  final pulmPts = ctx.singleSelect('euroscore-pulm_htn')?['value'] as num?;
  final urgencyPts = ctx.singleSelect('euroscore-urgency')?['value'] as num?;
  final procPts = ctx.singleSelect('euroscore-procedure')?['value'] as num?;
  final thorAorta =
      ctx.boolValue('euroscore-thoracic_aorta')?['value'] as bool?;
  final sepRupture =
      ctx.boolValue('euroscore-septal_rupture')?['value'] as bool?;

  final allComplete =
      age != null &&
      female != null &&
      creatHigh != null &&
      arterio != null &&
      poorMob != null &&
      prevSurg != null &&
      copd != null &&
      endocard != null &&
      critical != null &&
      diabInsulin != null &&
      nyhaPts != null &&
      ccs4 != null &&
      lvPts != null &&
      recentMi != null &&
      pulmPts != null &&
      urgencyPts != null &&
      procPts != null &&
      thorAorta != null &&
      sepRupture != null;

  if (!allComplete) {
    return ScoreResult.incomplete(
      label: 'EuroSCORE II',
      interpretation: 'Bitte alle Pflichtfelder ausfüllen.',
    );
  }

  // Age coefficient: 0.0285181 per year
  final ageTerm = age!.toDouble() * 0.0285181;
  final femaleTerm = (female! ? 1.0 : 0.0) * 0.2196434;
  final creatTerm = (creatHigh! ? 1.0 : 0.0) * 0.6521653;
  final arterTerm = (arterio! ? 1.0 : 0.0) * 0.5360268;
  final mobTerm = (poorMob! ? 1.0 : 0.0) * 0.2407651;
  final prevTerm = (prevSurg! ? 1.0 : 0.0) * 1.118599;
  final copdTerm = (copd! ? 1.0 : 0.0) * 0.1886564;
  final endoTerm = (endocard! ? 1.0 : 0.0) * 0.6194522;
  final critTerm = (critical! ? 1.0 : 0.0) * 1.086517;
  final diabTerm = (diabInsulin! ? 1.0 : 0.0) * 0.3542749;
  final nyhaTerm = nyhaPts!.toDouble();
  final ccsTerm = (ccs4! ? 1.0 : 0.0) * 0.2226147;
  final lvTerm = lvPts!.toDouble();
  final miTerm = (recentMi! ? 1.0 : 0.0) * 0.1528943;
  final pulmTerm = pulmPts!.toDouble();
  final urgTerm = urgencyPts!.toDouble();
  final procTerm = procPts!.toDouble();
  final aortaTerm = (thorAorta! ? 1.0 : 0.0) * 0.6527205;
  final sepTerm = (sepRupture! ? 1.0 : 0.0) * 1.462009;

  final logit =
      -5.324537 +
      ageTerm +
      femaleTerm +
      creatTerm +
      arterTerm +
      mobTerm +
      prevTerm +
      copdTerm +
      endoTerm +
      critTerm +
      diabTerm +
      nyhaTerm +
      ccsTerm +
      lvTerm +
      miTerm +
      pulmTerm +
      urgTerm +
      procTerm +
      aortaTerm +
      sepTerm;

  final mortality = exp(logit) / (1 + exp(logit));
  final mortalityPct = (mortality * 100).toStringAsFixed(2);

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'EuroSCORE II',
    primaryResult: '$mortalityPct %',
    primaryInterpretation: 'Vorhergesagte 30-Tage-Operationsmortalität',
    secondaryLabel: 'Risikoklasse',
    secondaryResult: _riskClass(mortality),
  );
}

String _riskClass(double mortality) {
  if (mortality < 0.02) return 'Niedriges Risiko (< 2 %)';
  if (mortality < 0.05) return 'Mäßiges Risiko (2-5 %)';
  if (mortality < 0.10) return 'Hohes Risiko (5-10 %)';
  return 'Sehr hohes Risiko (> 10 %)';
}

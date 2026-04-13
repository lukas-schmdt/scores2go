import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

ScoreResult finneganFunction(Score score) {
  final ctx = FlatScoreContext(score: score);

  // ── CNS ────────────────────────────────────────────────────────────────────
  final cry = ctx.singleSelect('finnegan-cry')?['value'] as num? ?? 0;
  final sleep = ctx.singleSelect('finnegan-sleep')?['value'] as num? ?? 0;
  final moro = ctx.singleSelect('finnegan-moro')?['value'] as num? ?? 0;
  final tremorsDist =
      ctx.singleSelect('finnegan-tremors-disturbed')?['value'] as num? ?? 0;
  final tremorsUndist =
      ctx.singleSelect('finnegan-tremors-undisturbed')?['value'] as num? ?? 0;
  final muscleTone = ctx.boolValue('finnegan-muscle-tone')?['points'] as num? ?? 0;
  final excoriation = ctx.boolValue('finnegan-excoriation')?['points'] as num? ?? 0;
  final myoclonic = ctx.boolValue('finnegan-myoclonic-jerks')?['points'] as num? ?? 0;
  final convulsions = ctx.boolValue('finnegan-convulsions')?['points'] as num? ?? 0;

  // ── MVR ────────────────────────────────────────────────────────────────────
  final sweating = ctx.boolValue('finnegan-sweating')?['points'] as num? ?? 0;
  final fever = ctx.singleSelect('finnegan-fever')?['value'] as num? ?? 0;
  final yawning = ctx.boolValue('finnegan-yawning')?['points'] as num? ?? 0;
  final mottling = ctx.boolValue('finnegan-mottling')?['points'] as num? ?? 0;
  final nasalStuffiness =
      ctx.boolValue('finnegan-nasal-stuffiness')?['points'] as num? ?? 0;
  final sneezing = ctx.boolValue('finnegan-sneezing')?['points'] as num? ?? 0;
  final nasalFlaring =
      ctx.boolValue('finnegan-nasal-flaring')?['points'] as num? ?? 0;
  final respiratoryRate =
      ctx.singleSelect('finnegan-respiratory-rate')?['value'] as num? ?? 0;
  final retractions = ctx.boolValue('finnegan-retractions')?['points'] as num? ?? 0;

  // ── GI ─────────────────────────────────────────────────────────────────────
  final sucking = ctx.boolValue('finnegan-sucking')?['points'] as num? ?? 0;
  final feeding = ctx.boolValue('finnegan-feeding')?['points'] as num? ?? 0;
  final regurgitation =
      ctx.boolValue('finnegan-regurgitation')?['points'] as num? ?? 0;
  final vomiting = ctx.boolValue('finnegan-vomiting')?['points'] as num? ?? 0;
  final stools = ctx.singleSelect('finnegan-stools')?['value'] as num? ?? 0;

  // Check if any item has been answered
  final allVars = [
    ctx.singleSelect('finnegan-cry'),
    ctx.singleSelect('finnegan-sleep'),
    ctx.singleSelect('finnegan-moro'),
    ctx.singleSelect('finnegan-tremors-disturbed'),
    ctx.singleSelect('finnegan-tremors-undisturbed'),
    ctx.boolValue('finnegan-muscle-tone'),
    ctx.boolValue('finnegan-excoriation'),
    ctx.boolValue('finnegan-myoclonic-jerks'),
    ctx.boolValue('finnegan-convulsions'),
    ctx.boolValue('finnegan-sweating'),
    ctx.singleSelect('finnegan-fever'),
    ctx.boolValue('finnegan-yawning'),
    ctx.boolValue('finnegan-mottling'),
    ctx.boolValue('finnegan-nasal-stuffiness'),
    ctx.boolValue('finnegan-sneezing'),
    ctx.boolValue('finnegan-nasal-flaring'),
    ctx.singleSelect('finnegan-respiratory-rate'),
    ctx.boolValue('finnegan-retractions'),
    ctx.boolValue('finnegan-sucking'),
    ctx.boolValue('finnegan-feeding'),
    ctx.boolValue('finnegan-regurgitation'),
    ctx.boolValue('finnegan-vomiting'),
    ctx.singleSelect('finnegan-stools'),
  ];

  if (allVars.every((v) => v == null)) {
    return ScoreResult.incomplete(
      label: 'Finnegan NAS',
      interpretation: 'Complete at least one item to calculate the score.',
    );
  }

  final total = (cry +
          sleep +
          moro +
          tremorsDist +
          tremorsUndist +
          muscleTone +
          excoriation +
          myoclonic +
          convulsions +
          sweating +
          fever +
          yawning +
          mottling +
          nasalStuffiness +
          sneezing +
          nasalFlaring +
          respiratoryRate +
          retractions +
          sucking +
          feeding +
          regurgitation +
          vomiting +
          stools)
      .toInt();

  final answeredCount = allVars.where((v) => v != null).length;
  final isComplete = answeredCount == allVars.length;

  if (!isComplete) {
    return ScoreResult(
      state: ScoreState.incomplete,
      primaryLabel: 'Finnegan NAS (partial)',
      primaryResult: '$total',
      primaryInterpretation:
          '${allVars.length - answeredCount} item(s) not yet assessed.',
    );
  }

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'Finnegan NAS',
    primaryResult: '$total',
    primaryInterpretation: _interpret(total),
  );
}

String _interpret(int score) {
  if (score < 8) return 'Mild withdrawal — supportive care';
  if (score < 12) return 'Moderate withdrawal — consider pharmacotherapy';
  return 'Severe withdrawal — pharmacotherapy indicated';
}

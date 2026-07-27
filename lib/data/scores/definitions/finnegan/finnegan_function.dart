import 'package:scores_2_go/data/scores/definitions/finnegan/finnegan_i10n.dart';
import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final _i10n = FinneganI10n();

ScoreResult finneganFunction(Score score, String lang) {
  String t(String key) => _i10n.t(lang, key);
  final ctx = FlatScoreContext(score: score);

  // ── CNS ────────────────────────────────────────────────────────────────────
  final cry = ctx.singleSelect('finnegan-cry')?['value'] as num? ?? 0;
  final sleep = ctx.singleSelect('finnegan-sleep')?['value'] as num? ?? 0;
  final moro = ctx.singleSelect('finnegan-moro')?['value'] as num? ?? 0;
  final tremors = ctx.singleSelect('finnegan-tremors')?['value'] as num? ?? 0;
  final muscleTone = ctx.boolValue('finnegan-muscle-tone')?['points'] as num? ?? 0;
  final excoriation = ctx.boolValue('finnegan-excoriation')?['points'] as num? ?? 0;
  final myoclonic = ctx.boolValue('finnegan-myoclonic-jerks')?['points'] as num? ?? 0;
  final convulsions = ctx.boolValue('finnegan-convulsions')?['points'] as num? ?? 0;

  final cnsTotal = cry +
      sleep +
      moro +
      tremors +
      muscleTone +
      excoriation +
      myoclonic +
      convulsions;

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

  final mvrTotal = sweating +
      fever +
      yawning +
      mottling +
      nasalStuffiness +
      sneezing +
      nasalFlaring +
      respiratoryRate;

  // ── GI ─────────────────────────────────────────────────────────────────────
  final sucking = ctx.boolValue('finnegan-sucking')?['points'] as num? ?? 0;
  final feeding = ctx.boolValue('finnegan-feeding')?['points'] as num? ?? 0;
  final regurgitation =
      ctx.boolValue('finnegan-regurgitation')?['points'] as num? ?? 0;
  final vomiting = ctx.boolValue('finnegan-vomiting')?['points'] as num? ?? 0;
  final stools = ctx.singleSelect('finnegan-stools')?['value'] as num? ?? 0;

  final giTotal = sucking + feeding + regurgitation + vomiting + stools;

  // Check if any item has been answered
  final allVars = [
    ctx.singleSelect('finnegan-cry'),
    ctx.singleSelect('finnegan-sleep'),
    ctx.singleSelect('finnegan-moro'),
    ctx.singleSelect('finnegan-tremors'),
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
    ctx.boolValue('finnegan-sucking'),
    ctx.boolValue('finnegan-feeding'),
    ctx.boolValue('finnegan-regurgitation'),
    ctx.boolValue('finnegan-vomiting'),
    ctx.singleSelect('finnegan-stools'),
  ];

  if (allVars.every((v) => v == null)) {
    return ScoreResult.incomplete(
      label: 'Finnegan NAS',
      interpretation: t('calc.incomplete'),
    );
  }

  final total = (cnsTotal + mvrTotal + giTotal).toInt();
  final domainBreakdown =
      '${cnsTotal.toInt()} / ${mvrTotal.toInt()} / ${giTotal.toInt()}';

  final answeredCount = allVars.where((v) => v != null).length;
  final isComplete = answeredCount == allVars.length;

  if (!isComplete) {
    return ScoreResult(
      state: ScoreState.incomplete,
      primaryLabel: t('calc.partialLabel'),
      primaryResult: '$total / 46',
      primaryInterpretation: t('calc.itemsNotAssessed')
          .replaceFirst('{n}', '${allVars.length - answeredCount}'),
      secondaryLabel: t('calc.domainLabel'),
      secondaryResult: domainBreakdown,
    );
  }

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'Finnegan NAS',
    primaryResult: '$total / 46',
    primaryInterpretation: _interpret(total, t),
    secondaryLabel: t('calc.domainLabel'),
    secondaryResult: domainBreakdown,
  );
}

String _interpret(int score, String Function(String) t) {
  if (score < 8) return t('calc.interp.mild');
  if (score < 12) return t('calc.interp.moderate');
  return t('calc.interp.severe');
}

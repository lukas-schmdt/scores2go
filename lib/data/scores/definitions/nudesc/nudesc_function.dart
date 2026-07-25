import 'package:scores_2_go/data/scores/definitions/nudesc/nudesc_i10n.dart';
import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final _i10n = NudescI10n();

ScoreResult nudescFunction(Score score, String lang) {
  String t(String key) => _i10n.t(lang, key);
  final ctx = FlatScoreContext(score: score);

  final disorientation = ctx.singleSelect('nudesc-disorientation')?['value'] as num?;
  final inappropriateBehavior = ctx.singleSelect('nudesc-inappropriate-behavior')?['value'] as num?;
  final inappropriateCommunication = ctx.singleSelect('nudesc-inappropriate-communication')?['value'] as num?;
  final illusions = ctx.singleSelect('nudesc-illusions')?['value'] as num?;
  final psychomotorRetardation = ctx.singleSelect('nudesc-psychomotor-retardation')?['value'] as num?;

  if (disorientation == null ||
      inappropriateBehavior == null ||
      inappropriateCommunication == null ||
      illusions == null ||
      psychomotorRetardation == null) {
    return ScoreResult.incomplete(
      label: 'Nu-DESC',
      interpretation: t('calc.incomplete'),
    );
  }

  final total = (disorientation +
          inappropriateBehavior +
          inappropriateCommunication +
          illusions +
          psychomotorRetardation)
      .toInt();

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'Nu-DESC',
    primaryResult: '$total / 10',
    primaryInterpretation: _interpret(total, t),
  );
}

String _interpret(int total, String Function(String) t) => switch (total) {
      0 => t('calc.interp.0'),
      1 => t('calc.interp.1'),
      _ when total >= 2 && total <= 4 => t('calc.interp.2to4'),
      _ => t('calc.interp.severe'),
    };

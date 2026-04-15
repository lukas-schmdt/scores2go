import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

ScoreResult nudescFunction(Score score) {
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
      interpretation: 'Please rate all 5 items to obtain a score.',
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
    primaryInterpretation: _interpret(total),
  );
}

String _interpret(int total) => switch (total) {
      0 => 'No delirium detected.',
      1 => 'No delirium detected (borderline — reassess regularly).',
      _ when total >= 2 && total <= 4 => 'Delirium likely (score ≥ 2) — further clinical assessment recommended.',
      _ => 'Severe delirium likely — immediate clinical assessment required.',
    };

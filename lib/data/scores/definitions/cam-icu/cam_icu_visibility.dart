import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

// Features 3 and 4 are only shown when both Feature 1 and Feature 2 are positive.
ScoreVisibility camIcuVisibility(Score score) {
  final ctx = FlatScoreContext(score: score);
  final f1 = ctx.boolValue('cam-icu-feature1')?['value'] as bool?;
  final f2 = ctx.boolValue('cam-icu-feature2')?['value'] as bool?;
  final showF3F4 = f1 == true && f2 == true;

  return ScoreVisibility(
    activeVariableNames: {
      'cam-icu-feature1',
      'cam-icu-feature2',
      if (showF3F4) 'cam-icu-feature3',
      if (showF3F4) 'cam-icu-feature4',
    },
  );
}

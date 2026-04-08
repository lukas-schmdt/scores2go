import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

/// pao2_fio2 is only shown when the patient is mechanically ventilated.
ScoreVisibility saps3Visibility(Score score) {
  final ctx = FlatScoreContext(score: score);
  final ventilated = ctx.boolValue('saps3-ventilated')?['value'] as bool?;

  final active = score.groups
      .expand((g) => g.items)
      .map((v) => v.name)
      .where((name) {
        if (name == 'saps3-pao2_fio2') return ventilated == true;
        return true;
      })
      .toSet();

  return ScoreVisibility(activeVariableNames: active);
}

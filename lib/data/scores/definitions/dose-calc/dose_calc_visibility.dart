import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

ScoreVisibility doseCalcVisibility(Score score) {
  final ctx = FlatScoreContext(score: score);
  final mode = ctx.singleSelect('dose-calc-mode')?['value'] as num?;

  return ScoreVisibility(
    activeVariableNames: {
      'dose-calc-weight',
      'dose-calc-conc-amount',
      'dose-calc-conc-volume',
      'dose-calc-mode',
      if (mode == 1) 'dose-calc-dose',
      if (mode == 2) 'dose-calc-rate',
    },
  );
}

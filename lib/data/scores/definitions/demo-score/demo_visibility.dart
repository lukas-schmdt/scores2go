import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

// FiO₂ (demo-score-fio2) only shown when mechanically ventilated
// (demo-score-ventilated = true).
ScoreVisibility demoScoreVisibility(Score score) {
  final ctx = FlatScoreContext(score: score);
  final vented = ctx.boolValue('demo-score-ventilated');
  final isVented = (vented?['value'] as bool?) ?? false;

  return ScoreVisibility(
    activeVariableNames: {
      'demo-score-o2_therapy',
      'demo-score-temperature',
      'demo-score-alertness',
      'demo-score-ventilated',
      if (isVented) 'demo-score-fio2',
      'demo-score-comorbidities',
      'demo-score-blood_sugar',
    },
  );
}

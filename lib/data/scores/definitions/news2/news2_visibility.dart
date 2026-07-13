import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

// SpO₂ Scale 1 shown when patient has no hypercapnic respiratory failure risk.
// SpO₂ Scale 2 shown when hypercapnic risk is confirmed (target 88–92%).
ScoreVisibility news2Visibility(Score score) {
  final ctx = FlatScoreContext(score: score);
  final hypercapnic =
      (ctx.boolValue('news2-hypercapnic')?['value'] as bool?) ?? false;

  return ScoreVisibility(
    activeVariableNames: {
      'news2-rr',
      'news2-hypercapnic',
      if (hypercapnic) 'news2-spo2-2' else 'news2-spo2-1',
      'news2-o2',
      'news2-sbp',
      'news2-pulse',
      'news2-consciousness',
      'news2-temp',
    },
  );
}

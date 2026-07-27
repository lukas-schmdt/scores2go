import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

const _notAssessableValue = -1;

// Items 2–8 are hidden once LOC (item 1) is rated A or B (coma/stupor) —
// the assessment halts there and those items are not rateable.
ScoreVisibility icdscVisibility(Score score) {
  final ctx = FlatScoreContext(score: score);
  final loc = ctx.singleSelect('icdsc-loc')?['value'] as num?;
  final notAssessable = loc == _notAssessableValue;

  return ScoreVisibility(
    activeVariableNames: {
      'icdsc-loc',
      if (!notAssessable) 'icdsc-inattention',
      if (!notAssessable) 'icdsc-disorientation',
      if (!notAssessable) 'icdsc-hallucinations',
      if (!notAssessable) 'icdsc-psychomotor',
      if (!notAssessable) 'icdsc-speech-mood',
      if (!notAssessable) 'icdsc-sleep-wake',
      if (!notAssessable) 'icdsc-fluctuation',
    },
  );
}

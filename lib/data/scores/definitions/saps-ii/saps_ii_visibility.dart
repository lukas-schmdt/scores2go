import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

// saps-ii-pao2_fio2 only shown when saps-ii-beatmet_oder_cpap = true.
ScoreVisibility sapsIiVisibility(Score score) {
  final ctx = FlatScoreContext(score: score);
  final isVentilated =
      (ctx.boolValue('saps-ii-beatmet_oder_cpap')?['value'] as bool?) ?? false;

  return ScoreVisibility(
    activeVariableNames: {
      'saps-ii-alter',
      'saps-ii-aufnahmeart',
      'saps-ii-chronische_erkrankungen',
      'saps-ii-herzfrequenz',
      'saps-ii-systolischer_blutdruck',
      'saps-ii-temperatur',
      'saps-ii-gcs',
      'saps-ii-beatmet_oder_cpap',
      if (isVentilated) 'saps-ii-pao2_fio2',
      'saps-ii-urinausscheidung',
      'saps-ii-bun',
      'saps-ii-leukozyten',
      'saps-ii-kalium',
      'saps-ii-natrium',
      'saps-ii-bicarbonat',
      'saps-ii-bilirubin',
    },
  );
}

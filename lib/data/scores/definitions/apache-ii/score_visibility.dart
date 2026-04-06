import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

// A-aDO₂ (apache-ii-aado2) only shown when FiO₂ ≥ 50 % (apache-ii-fio2_hoch = true).
// PaO₂   (apache-ii-pao2)  only shown when FiO₂ <  50 % (apache-ii-fio2_hoch = false or unanswered).
ScoreVisibility apacheIiVisibility(Score score) {
  final ctx = FlatScoreContext(score: score);
  final highFio2 = (ctx.boolValue('apache-ii-fio2_hoch')?['value'] as bool?) ?? false;

  return ScoreVisibility(
    activeVariableNames: {
      'apache-ii-temperatur',
      'apache-ii-map',
      'apache-ii-herzfrequenz',
      'apache-ii-atemfrequenz',
      'apache-ii-fio2_hoch',
      if (highFio2) 'apache-ii-aado2' else 'apache-ii-pao2',
      'apache-ii-ph_arteriell',
      'apache-ii-natrium',
      'apache-ii-kalium',
      'apache-ii-kreatinin',
      'apache-ii-arf',
      'apache-ii-haematokrit',
      'apache-ii-leukozyten',
      'apache-ii-gcs',
      'apache-ii-alter',
      'apache-ii-vorerkrankungen',
    },
  );
}

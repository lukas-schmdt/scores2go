import 'package:scores_2_go/data/scores/definitions/apache-ii/apache_ii_visibility.dart';
import 'package:scores_2_go/data/scores/definitions/demo-score/demo_visibility.dart';
import 'package:scores_2_go/data/scores/definitions/saps-ii/saps_ii_visibility.dart';
import 'package:scores_2_go/data/scores/definitions/sofa/sofa_visibility.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

final Map<String, ScoreVisibility Function(Score)> scoreVisibilityMapper = {
  'demo-score': demoScoreVisibility,
  'apache-ii': apacheIiVisibility,
  'saps-ii': sapsIiVisibility,
  'sofa': sofaVisibility,
};

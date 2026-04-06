import 'package:scores_2_go/data/scores/definitions/apache-ii/score_visibility.dart';
import 'package:scores_2_go/data/scores/definitions/demo-score/score_visibility.dart';
import 'package:scores_2_go/data/scores/definitions/saps-ii/score_visibility.dart';
import 'package:scores_2_go/data/scores/definitions/sofa/score_visibility.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

final Map<String, ScoreVisibility Function(Score)> scoreVisibilityMapper = {
  'demo-score': demoScoreVisibility,
  'apache-ii':  apacheIiVisibility,
  'saps-ii':    sapsIiVisibility,
  'sofa':       sofaVisibility,
};

import 'package:scores_2_go/data/scores/definitions/apache-ii/apache_ii_function.dart';
import 'package:scores_2_go/data/scores/definitions/demo-score/demo_function.dart';
import 'package:scores_2_go/data/scores/definitions/saps-ii/saps_ii_function.dart';
import 'package:scores_2_go/data/scores/definitions/sofa/sofa_function.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final Map<String, ScoreResult Function(Score)> scoreFunctionMapper = {
  'demo-score': demoScoreFunction,
  'apache-ii': apacheIiFunction,
  'saps-ii': sapsIiFunction,
  'sofa': sofaFunction,
};

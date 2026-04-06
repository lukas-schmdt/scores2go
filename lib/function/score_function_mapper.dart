import 'package:scores_2_go/data/scores/definitions/apache-ii/score_function.dart';
import 'package:scores_2_go/data/scores/definitions/demo-score/score_function.dart';
import 'package:scores_2_go/data/scores/definitions/saps-ii/score_function.dart';
import 'package:scores_2_go/data/scores/definitions/sofa/score_function.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final Map<String, ScoreResult Function(Score)> scoreFunctionMapper = {
  'demo-score': demoScoreFunction,
  'apache-ii':  apacheIiFunction,
  'saps-ii':    sapsIiFunction,
  'sofa':       sofaFunction,
};

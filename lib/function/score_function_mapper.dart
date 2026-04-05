import 'package:scores_2_go_2/function/score_function.dart';
import 'package:scores_2_go_2/model/score.dart';
import 'package:scores_2_go_2/model/score_result.dart';

Map<int, ScoreResult Function(Score)> scoreFunctionmapper = {
  1: demoMain,
  3: apache2Main,
};

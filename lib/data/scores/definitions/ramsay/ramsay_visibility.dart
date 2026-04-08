import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

// All Ramsay variables are always active.
ScoreVisibility ramsayVisibility(Score score) => const ScoreVisibility.all();

import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

// All qSOFA variables are always active.
ScoreVisibility qsofaVisibility(Score score) => const ScoreVisibility.all();

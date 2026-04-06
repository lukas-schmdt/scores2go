import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

// All SOFA variables are always active.
ScoreVisibility sofaVisibility(Score score) => const ScoreVisibility.all();

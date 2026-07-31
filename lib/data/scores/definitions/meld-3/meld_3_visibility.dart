import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

// All MELD 3.0 variables are always active.
ScoreVisibility meld3Visibility(Score score) => const ScoreVisibility.all();

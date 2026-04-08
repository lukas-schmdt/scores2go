import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

// All EuroSCORE II variables are always active.
ScoreVisibility euroscoreVisibility(Score score) => const ScoreVisibility.all();

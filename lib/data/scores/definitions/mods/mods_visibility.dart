import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

// All MODS variables are always active.
ScoreVisibility modsVisibility(Score score) => const ScoreVisibility.all();

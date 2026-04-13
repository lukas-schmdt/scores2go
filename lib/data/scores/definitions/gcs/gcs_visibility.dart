import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

// All GCS variables are always active.
ScoreVisibility gcsVisibility(Score score) => const ScoreVisibility.all();

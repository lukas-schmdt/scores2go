import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

// All Wells (PE) criteria are independent and always visible.
ScoreVisibility wellsPeVisibility(Score score) => const ScoreVisibility.all();

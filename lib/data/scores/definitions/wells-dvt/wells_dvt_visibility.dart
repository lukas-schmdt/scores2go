import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

// All Wells (DVT) criteria are independent and always visible.
ScoreVisibility wellsDvtVisibility(Score score) => const ScoreVisibility.all();

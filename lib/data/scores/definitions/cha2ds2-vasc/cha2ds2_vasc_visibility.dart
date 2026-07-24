import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';

// All CHA2DS2-VASc risk factors are independent and always visible.
ScoreVisibility cha2ds2VascVisibility(Score score) =>
    const ScoreVisibility.all();

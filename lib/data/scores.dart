import 'package:scores_2_go/data/scores/definitions/apache-ii/apache_ii.dart';
import 'package:scores_2_go/data/scores/definitions/demo-score/demo.dart';
import 'package:scores_2_go/data/scores/definitions/saps-ii/saps_ii.dart';
import 'package:scores_2_go/data/scores/definitions/sofa/sofa.dart';
import 'package:scores_2_go/model/score.dart';

List<Score> buildScoresDb(String lang) => [
  buildDemoScore(lang),
  buildApacheIiScore(lang),
  buildSapsIiScore(lang),
  buildSofaScore(lang),
];

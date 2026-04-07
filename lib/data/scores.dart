import 'package:scores_2_go/data/scores/definitions/apache-ii/apache_ii_definition.dart';
import 'package:scores_2_go/data/scores/definitions/demo-score/demo_definition.dart';
import 'package:scores_2_go/data/scores/definitions/saps-ii/saps_ii.dart';
import 'package:scores_2_go/data/scores/definitions/sofa/sofa.dart';
import 'package:scores_2_go/model/score.dart';

final List<Score> scoresDb = [
  buildDemoScore(),
  buildApacheIiScore(),
  buildSapsIiScore(),
  buildSofaScore(),
];

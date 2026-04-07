import 'package:scores_2_go/data/scores/definitions/apache-ii/apache_ii.dart';
import 'package:scores_2_go/data/scores/definitions/demo-score/demo.dart';
import 'package:scores_2_go/data/scores/definitions/saps-ii/saps_ii.dart';
import 'package:scores_2_go/data/scores/definitions/sofa/sofa.dart';
import 'package:scores_2_go/model/score.dart';

List<Score> buildScoresList(String lang) {
  final db = [
    buildDemoScore(lang),
    buildApacheIiScore(lang),
    buildSapsIiScore(lang),
    buildSofaScore(lang),
  ];

  assert(() {
    final ids = db.map((s) => s.id).toList();
    final unique = ids.toSet();
    if (unique.length != ids.length) {
      final duplicates = ids
          .where((id) => ids.indexOf(id) != ids.lastIndexOf(id))
          .toSet();
      throw StateError('Duplicate score IDs detected: $duplicates');
    }
    return true;
  }());

  return db;
}

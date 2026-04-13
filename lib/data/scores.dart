import 'package:scores_2_go/data/scores/definitions/apache-ii/apache_ii.dart';
import 'package:scores_2_go/data/scores/definitions/demo-score/demo.dart';
import 'package:scores_2_go/data/scores/definitions/euroscore/euroscore.dart';
import 'package:scores_2_go/data/scores/definitions/finnegan/finnegan.dart';
import 'package:scores_2_go/data/scores/definitions/gcs/gcs.dart';
import 'package:scores_2_go/data/scores/definitions/meld/meld.dart';
import 'package:scores_2_go/data/scores/definitions/ramsay/ramsay.dart';
import 'package:scores_2_go/data/scores/definitions/rass/rass.dart';
import 'package:scores_2_go/data/scores/definitions/saps-3/saps_3.dart';
import 'package:scores_2_go/data/scores/definitions/saps-ii/saps_ii.dart';
import 'package:scores_2_go/data/scores/definitions/sofa/sofa.dart';
import 'package:scores_2_go/model/score.dart';

List<Score> buildScoresList(String lang) {
  final db = [
    buildDemoScore(lang),
    buildApacheIiScore(lang),
    buildSapsIiScore(lang),
    buildSofaScore(lang),
    buildGcsScore(lang),
    buildMeldScore(lang),
    buildFinneganScore(lang),
    buildRassScore(lang),
    buildRamsayScore(lang),
    buildSaps3Score(lang),
    buildEuroscoreScore(lang),
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

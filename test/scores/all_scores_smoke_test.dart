import 'package:flutter_test/flutter_test.dart';
import 'package:scores_2_go/data/scores.dart';
import 'package:scores_2_go/model/model.dart';

void main() {
  test('buildScoresList builds without throwing and has unique ids', () {
    final scores = buildScoresList('en');
    expect(scores, isNotEmpty);
    final ids = scores.map((s) => s.id).toList();
    expect(ids.toSet().length, ids.length, reason: 'score ids must be unique');
  });

  test('dose-calc is no longer registered', () {
    final names = buildScoresList('en').map((s) => s.name).toList();
    expect(names, isNot(contains('dose-calc')));
  });

  for (final lang in ['en', 'de']) {
    test('every score function runs on empty input without throwing ($lang)', () {
      for (final score in buildScoresList(lang)) {
        final fn = score.scoreFunction;
        if (fn == null) continue;
        // Should return a result (typically incomplete), never throw.
        final result = fn(score);
        expect(
          result,
          isA<ScoreResult>(),
          reason: 'score "${score.name}" returned null',
        );
      }
    });
  }
}

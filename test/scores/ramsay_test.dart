import 'package:flutter_test/flutter_test.dart';
import 'package:scores_2_go/data/scores/definitions/ramsay/ramsay.dart';
import 'package:scores_2_go/model/model.dart';

import '../support/score_input.dart';

void main() {
  final score = buildRamsayScore('en');

  test('nothing selected → incomplete', () {
    final r = compute(score, {});
    expect(r.state, ScoreState.incomplete);
  });

  test('level 1 → agitated band', () {
    final r = compute(score, {'ramsay-level': 1});
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, 'Level 1');
    expect(r.primaryInterpretation, contains('anxious'));
    expect(r.secondaryResult, contains('inadequate sedation'));
  });

  for (final level in [2, 3]) {
    test('level $level → commonly used light-sedation target', () {
      final r = compute(score, {'ramsay-level': level});
      expect(r.primaryResult, 'Level $level');
      expect(r.secondaryResult, contains('light-sedation target'));
    });
  }

  for (final level in [4, 5]) {
    test('level $level → deeper sedation, stimulus named', () {
      final r = compute(score, {'ramsay-level': level});
      expect(r.primaryResult, 'Level $level');
      expect(r.primaryInterpretation, contains('glabellar tap'));
      expect(r.secondaryResult, contains('Deeper sedation'));
    });
  }

  // Regression: level 6 used to be labelled "possible overdose", which no
  // source supports — unresponsiveness may be intended or neurological.
  test('level 6 → unresponsive, no overdose claim', () {
    final r = compute(score, {'ramsay-level': 6});
    expect(r.primaryResult, 'Level 6');
    expect(r.primaryInterpretation, contains('no response to glabellar tap'));
    expect(r.secondaryResult, contains('Unresponsive'));
    expect(r.secondaryResult!.toLowerCase(), isNot(contains('overdose')));
  });

  test('German strings are used for de', () {
    final r = compute(buildRamsayScore('de'), {'ramsay-level': 6});
    expect(r.primaryResult, 'Stufe 6');
    expect(r.secondaryResult, isNot(contains('Überdosierung')));
  });
}

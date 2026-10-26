import 'package:flutter_test/flutter_test.dart';
import 'package:scores_2_go/data/scores/definitions/rass/rass.dart';
import 'package:scores_2_go/model/model.dart';

import '../support/score_input.dart';

void main() {
  final score = buildRassScore('en');

  test('nothing selected → incomplete', () {
    final r = compute(score, {});
    expect(r.state, ScoreState.incomplete);
  });

  test('positive levels carry a plus sign, zero does not', () {
    expect(compute(score, {'rass-level': 4}).primaryResult, '+4');
    expect(compute(score, {'rass-level': 0}).primaryResult, '0');
    expect(compute(score, {'rass-level': -5}).primaryResult, '-5');
  });

  for (final level in [1, 2, 3, 4]) {
    test('level +$level → agitation, consider pain and hyperactive delirium', () {
      final r = compute(score, {'rass-level': level});
      expect(r.secondaryResult, contains('hyperactive delirium'));
      expect(r.secondaryInterpretation, isNull);
    });
  }

  for (final level in [0, -1, -2]) {
    test('level $level → light-sedation range', () {
      final r = compute(score, {'rass-level': level});
      expect(r.secondaryResult, contains('RASS -2 to 0'));
      expect(r.secondaryInterpretation, isNull);
    });
  }

  test('level -3 → counted as deep sedation, screening not limited', () {
    final r = compute(score, {'rass-level': -3});
    expect(r.primaryInterpretation, contains('no eye contact'));
    expect(r.secondaryResult, contains('deep sedation in outcome studies'));
    expect(r.secondaryInterpretation, isNull);
  });

  for (final level in [-4, -5]) {
    test('level $level → coma range, delirium screening limited', () {
      final r = compute(score, {'rass-level': level});
      expect(r.secondaryResult, contains('Coma range'));
      expect(r.secondaryInterpretation, contains('ICDSC items 1–4'));
    });
  }

  test('German strings are used for de', () {
    final de = buildRassScore('de');
    expect(compute(de, {'rass-level': 0}).primaryInterpretation,
        'Wach und ruhig');
    expect(compute(de, {'rass-level': 4}).primaryInterpretation,
        startsWith('Aggressiv'));
    expect(compute(de, {'rass-level': -5}).secondaryResult,
        startsWith('Komabereich'));
  });
}

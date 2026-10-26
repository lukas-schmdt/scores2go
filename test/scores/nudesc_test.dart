import 'package:flutter_test/flutter_test.dart';
import 'package:scores_2_go/data/scores/definitions/nudesc/nudesc.dart';
import 'package:scores_2_go/model/model.dart';

import '../support/score_input.dart';

const _names = [
  'nudesc-disorientation',
  'nudesc-inappropriate-behavior',
  'nudesc-inappropriate-communication',
  'nudesc-illusions',
  'nudesc-psychomotor-retardation',
];

Map<String, Object?> _items(List<int?> v) => {
      for (var i = 0; i < _names.length; i++) _names[i]: v[i],
    };

void main() {
  final score = buildNudescScore('en');

  test('all 0 → 0 / 10, negative screen', () {
    final r = compute(score, _items([0, 0, 0, 0, 0]));
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '0 / 10');
    expect(r.primaryInterpretation, contains('Negative screen'));
  });

  test('[1,0,0,0,0] → 1 / 10, negative at standard cutoff', () {
    final r = compute(score, _items([1, 0, 0, 0, 0]));
    expect(r.primaryResult, '1 / 10');
    expect(r.primaryInterpretation, contains('Negative at the standard cutoff'));
    expect(r.primaryInterpretation!.toLowerCase(), isNot(contains('borderline')));
  });

  test('[0,0,0,0,2] → 2 / 10, positive screen', () {
    final r = compute(score, _items([0, 0, 0, 0, 2]));
    expect(r.primaryResult, '2 / 10');
    expect(r.primaryInterpretation, contains('Positive screen'));
  });

  test('all 2 → 10 / 10, positive, no severity grading', () {
    final r = compute(score, _items([2, 2, 2, 2, 2]));
    expect(r.primaryResult, '10 / 10');
    expect(r.primaryInterpretation, contains('Positive screen'));
    expect(r.primaryInterpretation!.toLowerCase(), isNot(contains('severe')));
  });

  test('one item unset → incomplete', () {
    final r = compute(score, _items([0, 0, null, 0, 0]));
    expect(r.state, ScoreState.incomplete);
  });

  test('German locale computes the same totals', () {
    final r = compute(buildNudescScore('de'), _items([2, 0, 0, 0, 0]));
    expect(r.primaryResult, '2 / 10');
    expect(r.primaryInterpretation, contains('Positives Screening'));
  });
}

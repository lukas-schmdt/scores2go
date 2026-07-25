import 'package:flutter_test/flutter_test.dart';
import 'package:scores_2_go/data/scores/definitions/qsofa/qsofa.dart';
import 'package:scores_2_go/model/model.dart';

import '../support/score_input.dart';

void main() {
  final score = buildQsofaScore('en');

  test('all criteria unanswered → incomplete', () {
    final r = compute(score, {});
    expect(r.state, ScoreState.incomplete);
  });

  test('partially answered → incomplete', () {
    final r = compute(score, {'qsofa-resp-rate': true});
    expect(r.state, ScoreState.incomplete);
  });

  test('all negative → total 0, low risk', () {
    final r = compute(score, {
      'qsofa-resp-rate': false,
      'qsofa-mentation': false,
      'qsofa-sbp': false,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '0 / 3');
    expect(r.primaryInterpretation, contains('Low risk'));
  });

  test('two positive → total 2, high risk', () {
    final r = compute(score, {
      'qsofa-resp-rate': true,
      'qsofa-mentation': true,
      'qsofa-sbp': false,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '2 / 3');
    expect(r.primaryInterpretation, contains('High risk'));
  });

  test('all positive → total 3', () {
    final r = compute(score, {
      'qsofa-resp-rate': true,
      'qsofa-mentation': true,
      'qsofa-sbp': true,
    });
    expect(r.primaryResult, '3 / 3');
  });
}

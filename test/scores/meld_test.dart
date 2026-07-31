import 'package:flutter_test/flutter_test.dart';
import 'package:scores_2_go/data/scores/definitions/meld/meld.dart';
import 'package:scores_2_go/model/model.dart';

import '../support/score_input.dart';

void main() {
  final score = buildMeldScore('en');

  test('nothing entered → incomplete', () {
    final r = compute(score, {});
    expect(r.state, ScoreState.incomplete);
  });

  test('only bilirubin entered → incomplete', () {
    final r = compute(score, {'meld-bilirubin': 1.0});
    expect(r.state, ScoreState.incomplete);
  });

  test('bilirubin and INR entered, creatinine missing → incomplete', () {
    final r = compute(score, {'meld-bilirubin': 1.0, 'meld-inr': 1.0});
    expect(r.state, ScoreState.incomplete);
  });

  test('dialysis left unanswered does not block calculation', () {
    final r = compute(score, {
      'meld-bilirubin': 0.8,
      'meld-inr': 1.0,
      'meld-creatinine': 0.9,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '6');
  });

  group('verified worked examples', () {
    test('bilirubin 0.8, INR 1.0, creatinine 0.9, no dialysis → 6.43 → 6 (mathematical floor)', () {
      final r = compute(score, {
        'meld-bilirubin': 0.8,
        'meld-inr': 1.0,
        'meld-creatinine': 0.9,
        'meld-dialysis': false,
      });
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, '6');
    });

    test('bilirubin 2.5, INR 1.8, creatinine 3.2, on dialysis (→ creat 4.0) → 29.74 → 30', () {
      final r = compute(score, {
        'meld-bilirubin': 2.5,
        'meld-inr': 1.8,
        'meld-creatinine': 3.2,
        'meld-dialysis': true,
      });
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, '30');
    });

    test('bilirubin 3.0, INR 1.5, creatinine 1.8, no dialysis → 20.75 → 21', () {
      final r = compute(score, {
        'meld-bilirubin': 3.0,
        'meld-inr': 1.5,
        'meld-creatinine': 1.8,
        'meld-dialysis': false,
      });
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, '21');
    });

    test('bilirubin 8.0, INR 2.5, creatinine 5.0 (clamps to 4.0), no dialysis → 37.82 → 38', () {
      final r = compute(score, {
        'meld-bilirubin': 8.0,
        'meld-inr': 2.5,
        'meld-creatinine': 5.0,
        'meld-dialysis': false,
      });
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, '38');
    });
  });

  test('creatinine 5.0 and creatinine 4.0 give the same result (ceiling clamp)', () {
    final base = {'meld-bilirubin': 1.0, 'meld-inr': 1.0, 'meld-dialysis': false};
    final r5 = compute(score, {...base, 'meld-creatinine': 5.0});
    final r4 = compute(score, {...base, 'meld-creatinine': 4.0});
    expect(r5.primaryResult, r4.primaryResult);
  });

  test('bilirubin 0.5 and bilirubin 1.0 give the same result (floor clamp)', () {
    final base = {'meld-inr': 1.0, 'meld-creatinine': 1.0, 'meld-dialysis': false};
    final rLow = compute(score, {...base, 'meld-bilirubin': 0.5});
    final rFloor = compute(score, {...base, 'meld-bilirubin': 1.0});
    expect(rLow.primaryResult, rFloor.primaryResult);
  });

  test('INR 0.5 and INR 1.0 give the same result (floor clamp)', () {
    final base = {'meld-bilirubin': 1.0, 'meld-creatinine': 1.0, 'meld-dialysis': false};
    final rLow = compute(score, {...base, 'meld-inr': 0.5});
    final rFloor = compute(score, {...base, 'meld-inr': 1.0});
    expect(rLow.primaryResult, rFloor.primaryResult);
  });

  test('the 40 ceiling actually clamps on extreme inputs', () {
    final r = compute(score, {
      'meld-bilirubin': 50.0,
      'meld-inr': 10.0,
      'meld-creatinine': 10.0,
      'meld-dialysis': false,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '40');
  });

  group('precise mortality figures by band', () {
    test('MELD 6 (<10) → 1.9 %', () {
      final r = compute(score, {
        'meld-bilirubin': 0.8,
        'meld-inr': 1.0,
        'meld-creatinine': 0.9,
        'meld-dialysis': false,
      });
      expect(r.primaryResult, '6');
      expect(r.secondaryResult, '1.9 %');
    });

    test('MELD 10 (10–19) → 6.0 %', () {
      final r = compute(score, {
        'meld-bilirubin': 1.5,
        'meld-inr': 1.2,
        'meld-creatinine': 1.0,
        'meld-dialysis': false,
      });
      expect(r.primaryResult, '10');
      expect(r.secondaryResult, '6.0 %');
    });

    test('MELD 21 (20–29) → 19.6 %', () {
      final r = compute(score, {
        'meld-bilirubin': 3.0,
        'meld-inr': 1.5,
        'meld-creatinine': 1.8,
        'meld-dialysis': false,
      });
      expect(r.primaryResult, '21');
      expect(r.secondaryResult, '19.6 %');
    });

    test('MELD 30 (30–39) → 52.6 %', () {
      final r = compute(score, {
        'meld-bilirubin': 2.5,
        'meld-inr': 1.8,
        'meld-creatinine': 3.2,
        'meld-dialysis': true,
      });
      expect(r.primaryResult, '30');
      expect(r.secondaryResult, '52.6 %');
    });

    test('MELD 40 (≥40) → 71.3 %', () {
      final r = compute(score, {
        'meld-bilirubin': 50.0,
        'meld-inr': 10.0,
        'meld-creatinine': 10.0,
        'meld-dialysis': false,
      });
      expect(r.primaryResult, '40');
      expect(r.secondaryResult, '71.3 %');
    });
  });

  test('German locale produces a non-empty interpretation with no leaked English and no raw i10n keys', () {
    final de = buildMeldScore('de');
    final r = compute(de, {
      'meld-bilirubin': 3.0,
      'meld-inr': 1.5,
      'meld-creatinine': 1.8,
      'meld-dialysis': false,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryInterpretation, isNotEmpty);
    expect(r.primaryInterpretation, contains('Hoch'));
    expect(r.primaryInterpretation, isNot(contains('calc.')));
    expect(r.primaryInterpretation, isNot(contains('High')));
    expect(r.primaryLabel, isNot(contains('display')));
    expect(r.secondaryLabel, isNot(contains('calc.')));
  });
}

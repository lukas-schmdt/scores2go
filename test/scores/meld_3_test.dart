import 'package:flutter_test/flutter_test.dart';
import 'package:scores_2_go/data/scores/definitions/meld-3/meld_3.dart';
import 'package:scores_2_go/model/model.dart';

import '../support/score_input.dart';

void main() {
  final score = buildMeld3Score('en');

  // Worked example A (male): bili 2.0, INR 1.3, creat 1.5, Na 133, alb 2.8,
  // no dialysis. Intermediate sum 19.4527 → rounds to 19.
  const exampleAMale = {
    'meld3-sex': 0,
    'meld3-bilirubin': 2.0,
    'meld3-inr': 1.3,
    'meld3-creatinine': 1.5,
    'meld3-sodium': 133,
    'meld3-albumin': 2.8,
  };

  test('nothing entered → incomplete', () {
    final r = compute(score, {});
    expect(r.state, ScoreState.incomplete);
  });

  group('each required input missing individually → incomplete', () {
    for (final key in exampleAMale.keys) {
      test('missing $key', () {
        final values = Map<String, Object?>.from(exampleAMale)..remove(key);
        final r = compute(score, values);
        expect(r.state, ScoreState.incomplete);
      });
    }
  });

  test('dialysis left unanswered does NOT block calculation', () {
    final r = compute(score, exampleAMale);
    expect(r.state, ScoreState.success);
  });

  group('worked examples (verified independently)', () {
    test('A: male, bili 2.0, INR 1.3, creat 1.5, Na 133, alb 2.8, no dialysis → 19', () {
      final r = compute(score, exampleAMale);
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, '19');
    });

    test('B: identical to A but female → 21', () {
      final values = Map<String, Object?>.from(exampleAMale)
        ..['meld3-sex'] = 1.33;
      final r = compute(score, values);
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, '21');
    });

    test('A vs B: sex adjustment produces exactly a 2-point difference across a rounding boundary', () {
      final rA = compute(score, exampleAMale);
      final rB = compute(score, {
        ...exampleAMale,
        'meld3-sex': 1.33,
      });
      expect(int.parse(rB.primaryResult!) - int.parse(rA.primaryResult!), 2);
    });

    test('C: female, bili 5.0, INR 2.0, on dialysis (creat forced to 3.0), Na 128, alb 2.0 → 37', () {
      final r = compute(score, {
        'meld3-sex': 1.33,
        'meld3-bilirubin': 5.0,
        'meld3-inr': 2.0,
        'meld3-creatinine': 1.0, // irrelevant — dialysis forces 3.0
        'meld3-sodium': 128,
        'meld3-albumin': 2.0,
        'meld3-dialysis': true,
      });
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, '37');
    });
  });

  group('creatinine 3.0 ceiling', () {
    test('creatinine 5.0 gives the same result as creatinine 3.0 (both clamp to 3.0)', () {
      final rAt3 = compute(score, {...exampleAMale, 'meld3-creatinine': 3.0});
      final rAt5 = compute(score, {...exampleAMale, 'meld3-creatinine': 5.0});
      expect(rAt5.primaryResult, rAt3.primaryResult);
    });

    test('dialysis forces creatinine to 3.0 regardless of the entered lab value', () {
      final rDialysisLowCreat = compute(score, {
        ...exampleAMale,
        'meld3-creatinine': 0.6,
        'meld3-dialysis': true,
      });
      final rManual3 = compute(score, {
        ...exampleAMale,
        'meld3-creatinine': 3.0,
        'meld3-dialysis': false,
      });
      expect(rDialysisLowCreat.primaryResult, rManual3.primaryResult);
    });
  });

  group('sodium 125–137 mmol/L bounds actually clamp', () {
    test('sodium below 125 clamps to 125', () {
      final rAt125 = compute(score, {...exampleAMale, 'meld3-sodium': 125});
      final rBelow = compute(score, {...exampleAMale, 'meld3-sodium': 110});
      expect(rBelow.primaryResult, rAt125.primaryResult);
    });

    test('sodium above 137 clamps to 137', () {
      final rAt137 = compute(score, {...exampleAMale, 'meld3-sodium': 137});
      final rAbove = compute(score, {...exampleAMale, 'meld3-sodium': 150});
      expect(rAbove.primaryResult, rAt137.primaryResult);
    });
  });

  group('albumin 1.5–3.5 g/dL bounds actually clamp', () {
    test('albumin below 1.5 clamps to 1.5', () {
      final rAt15 = compute(score, {...exampleAMale, 'meld3-albumin': 1.5});
      final rBelow = compute(score, {...exampleAMale, 'meld3-albumin': 0.8});
      expect(rBelow.primaryResult, rAt15.primaryResult);
    });

    test('albumin above 3.5 clamps to 3.5', () {
      final rAt35 = compute(score, {...exampleAMale, 'meld3-albumin': 3.5});
      final rAbove = compute(score, {...exampleAMale, 'meld3-albumin': 4.5});
      expect(rAbove.primaryResult, rAt35.primaryResult);
    });
  });

  test('all labs normal → floor of 6', () {
    final r = compute(score, {
      'meld3-sex': 0,
      'meld3-bilirubin': 1.0,
      'meld3-inr': 1.0,
      'meld3-creatinine': 1.0,
      'meld3-sodium': 140,
      'meld3-albumin': 4.0,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '6');
  });

  test('extreme abnormal labs → ceiling of 40', () {
    final r = compute(score, {
      'meld3-sex': 1.33,
      'meld3-bilirubin': 50.0,
      'meld3-inr': 10.0,
      'meld3-creatinine': 1.0,
      'meld3-sodium': 125,
      'meld3-albumin': 1.5,
      'meld3-dialysis': true,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '40');
  });

  group('physiologically impossible entries → error, not a number', () {
    test('bilirubin ≤ 0 → error', () {
      final r = compute(score, {...exampleAMale, 'meld3-bilirubin': 0});
      expect(r.state, ScoreState.error);
    });

    test('INR ≤ 0 → error', () {
      final r = compute(score, {...exampleAMale, 'meld3-inr': -1});
      expect(r.state, ScoreState.error);
    });

    test('creatinine ≤ 0 → error', () {
      final r = compute(score, {...exampleAMale, 'meld3-creatinine': 0});
      expect(r.state, ScoreState.error);
    });

    test('albumin ≤ 0 → error', () {
      final r = compute(score, {...exampleAMale, 'meld3-albumin': -2});
      expect(r.state, ScoreState.error);
    });
  });

  test('German locale produces non-empty interpretation with no leaked English or raw i10n keys', () {
    final de = buildMeld3Score('de');
    final r = compute(de, exampleAMale);
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '19');
    expect(r.primaryLabel, 'MELD 3.0');
    expect(r.primaryInterpretation, isNotEmpty);
    expect(r.primaryInterpretation, contains('Moderat'));
    expect(r.primaryInterpretation, isNot(contains('Moderate —')));
    // No untranslated i10n key artefacts leaking through.
    expect(r.primaryInterpretation, isNot(contains('calc.risk')));
    expect(r.secondaryLabel, isNot(contains('calc.mortality')));
  });
}

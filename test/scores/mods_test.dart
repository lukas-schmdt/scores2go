import 'package:flutter_test/flutter_test.dart';
import 'package:scores_2_go/data/scores/definitions/mods/mods.dart';
import 'package:scores_2_go/model/model.dart';

import '../support/score_input.dart';

void main() {
  final score = buildModsScore('en');

  test('nothing entered → incomplete', () {
    final r = compute(score, {});
    expect(r.state, ScoreState.incomplete);
  });

  test('only cardiovascular partially entered → incomplete, asks for HR/MAP/CVP', () {
    final r = compute(score, {'mods-hr': 80, 'mods-map': 70});
    expect(r.state, ScoreState.incomplete);
    expect(r.primaryInterpretation, contains('HR'));
  });

  test('five of six systems answered, cardiovascular missing → incomplete', () {
    final r = compute(score, {
      'mods-pf': 0,
      'mods-creatinine': 0,
      'mods-bilirubin': 0,
      'mods-platelets': 0,
      'mods-gcs': 0,
    });
    expect(r.state, ScoreState.incomplete);
  });

  test('MAP = 0 → cardiovascular defaults to worst score (4), no crash', () {
    final r = compute(score, {
      'mods-pf': 0,
      'mods-creatinine': 0,
      'mods-bilirubin': 0,
      'mods-platelets': 0,
      'mods-gcs': 0,
      'mods-hr': 80,
      'mods-map': 0,
      'mods-cvp': 5,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '4 / 24');
  });

  group('worked examples', () {
    test('Example A — mixed severity, PAR = 110×14/70 = 22.0 → total 10/24', () {
      final r = compute(score, {
        'mods-pf': 2, // 200 mmHg → 151–225 band
        'mods-creatinine': 1, // 150 µmol/L → 101–200 band
        'mods-bilirubin': 1, // 30 µmol/L → 21–60 band
        'mods-hr': 110,
        'mods-map': 70,
        'mods-cvp': 14,
        'mods-platelets': 1, // 90 ×10^9/L → 81–120 band
        'mods-gcs': 2, // GCS 11 → 10–12 band
      });
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, '10 / 24');
      expect(r.secondaryResult, 'PAR = 22.0');
    });

    test('Example B — all worst bands, PAR = 140×12/50 = 33.6 → total 24/24', () {
      final r = compute(score, {
        'mods-pf': 4,
        'mods-creatinine': 4,
        'mods-bilirubin': 4,
        'mods-hr': 140,
        'mods-map': 50,
        'mods-cvp': 12,
        'mods-platelets': 4,
        'mods-gcs': 4,
      });
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, '24 / 24');
      expect(r.primaryInterpretation, contains('Maximum'));
    });

    test('Example C — all normal, PAR = 80×5/85 ≈ 4.7 → total 0/24', () {
      final r = compute(score, {
        'mods-pf': 0,
        'mods-creatinine': 0,
        'mods-bilirubin': 0,
        'mods-hr': 80,
        'mods-map': 85,
        'mods-cvp': 5,
        'mods-platelets': 0,
        'mods-gcs': 0,
      });
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, '0 / 24');
      expect(r.primaryInterpretation, contains('No dysfunction'));
    });
  });

  group('PAR banding boundaries', () {
    // PAR = HR × CVP / MAP. Using MAP = 100, CVP = 10 → PAR numerically equals HR / 10.
    test('PAR = 10.0 (boundary) → 0 points', () {
      final r = compute(score, {
        'mods-pf': 0,
        'mods-creatinine': 0,
        'mods-bilirubin': 0,
        'mods-hr': 100,
        'mods-map': 100,
        'mods-cvp': 10,
        'mods-platelets': 0,
        'mods-gcs': 0,
      });
      expect(r.primaryResult, '0 / 24');
    });

    test('PAR = 10.1 (just above boundary) → 1 point', () {
      final r = compute(score, {
        'mods-pf': 0,
        'mods-creatinine': 0,
        'mods-bilirubin': 0,
        'mods-hr': 101,
        'mods-map': 100,
        'mods-cvp': 10,
        'mods-platelets': 0,
        'mods-gcs': 0,
      });
      expect(r.primaryResult, '1 / 24');
    });
  });

  group('total-score interpretation bands match literature mortality breakpoints', () {
    test('17–20 → distinct band from >20 (both previously collapsed into ">16")', () {
      // Respiratory=4, Renal=4, Hepatic=4, Platelets=4, GCS=1 → 17, cardio=0 (PAR small)
      final r17 = compute(score, {
        'mods-pf': 4,
        'mods-creatinine': 4,
        'mods-bilirubin': 4,
        'mods-hr': 60,
        'mods-map': 100,
        'mods-cvp': 5,
        'mods-platelets': 4,
        'mods-gcs': 1,
      });
      expect(r17.primaryResult, '17 / 24');
      expect(r17.primaryInterpretation, isNot(contains('Maximum')));

      final r24 = compute(score, {
        'mods-pf': 4,
        'mods-creatinine': 4,
        'mods-bilirubin': 4,
        'mods-hr': 140,
        'mods-map': 50,
        'mods-cvp': 12,
        'mods-platelets': 4,
        'mods-gcs': 4,
      });
      expect(r24.primaryResult, '24 / 24');
      expect(r24.primaryInterpretation, contains('Maximum'));
      expect(r24.primaryInterpretation, isNot(equals(r17.primaryInterpretation)));
    });
  });

  test('German locale produces non-empty interpretation with no leaked keys', () {
    final de = buildModsScore('de');
    final r = compute(de, {
      'mods-pf': 0,
      'mods-creatinine': 0,
      'mods-bilirubin': 0,
      'mods-hr': 80,
      'mods-map': 85,
      'mods-cvp': 5,
      'mods-platelets': 0,
      'mods-gcs': 0,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryInterpretation, isNotEmpty);
    expect(r.primaryInterpretation, isNot(contains('calc.interp')));
  });
}

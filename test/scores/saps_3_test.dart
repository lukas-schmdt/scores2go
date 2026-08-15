import 'package:flutter_test/flutter_test.dart';
import 'package:scores_2_go/data/scores/definitions/saps-3/saps_3.dart';
import 'package:scores_2_go/model/model.dart';

import '../support/score_input.dart';

void main() {
  final score = buildSaps3Score('en');

  // All bands at their lowest/reference category, not ventilated, no
  // comorbidities, not a surgical admission → total should be exactly 0.
  const zeroBaseline = {
    'saps3-age': 0,
    'saps3-ventilated': false,
    'saps3-location': 0,
    'saps3-surgical': false,
    'saps3-reason': 0,
    'saps3-gcs': 0,
    'saps3-bilirubin': 0,
    'saps3-temperature': 0,
    'saps3-heart_rate': 0,
    'saps3-map': 0,
    'saps3-creatinine': 0,
    'saps3-platelets': 0,
    'saps3-wbc': 0,
    'saps3-ph': 0,
  };

  double parsePercent(String interpretation) {
    final match = RegExp(r'([\d.]+)\s*%').firstMatch(interpretation);
    return double.parse(match!.group(1)!);
  }

  test('nothing entered → incomplete', () {
    final r = compute(score, {});
    expect(r.state, ScoreState.incomplete);
  });

  test('ventilated but PaO2/FiO2 not answered → incomplete', () {
    final r = compute(score, {...zeroBaseline, 'saps3-ventilated': true});
    expect(r.state, ScoreState.incomplete);
  });

  test('ventilated status unanswered → incomplete even if all else filled', () {
    final r = Map<String, Object?>.from(zeroBaseline)
      ..remove('saps3-ventilated');
    final result = compute(score, r);
    expect(result.state, ScoreState.incomplete);
  });

  test('all-zero baseline, not ventilated, no comorbidities → total 0 points', () {
    final r = compute(score, zeroBaseline);
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '0 points');
  });

  group('verified-correct point bands (high-confidence, cross-checked)', () {
    test('age ≥ 80 → 18 points', () {
      final r = compute(score, {...zeroBaseline, 'saps3-age': 18});
      expect(r.primaryResult, '18 points');
    });

    test('creatinine ≥ 3.5 mg/dL → 8 points', () {
      final r = compute(score, {...zeroBaseline, 'saps3-creatinine': 8});
      expect(r.primaryResult, '8 points');
    });
  });

  group('comorbidities are independent additive checkboxes (not a hierarchy)', () {
    // Cirrhosis (4) and AIDS (8) — chosen because their point values are
    // unique among the 7 options (three other options also score 6, which
    // would collide with a value-based multi-select in this test harness).
    test('Cirrhosis (4) + AIDS (8) both selected → sums to 12, not just the higher one', () {
      final r = compute(score, {
        ...zeroBaseline,
        'saps3-comorbidities': [4, 8],
      });
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, '12 points');
    });
  });

  group('mechanical ventilation gates the oxygenation sub-score', () {
    test('not ventilated → 0 oxygenation points regardless of anything else', () {
      final r = compute(score, zeroBaseline);
      expect(r.primaryResult, '0 points');
    });

    test('ventilated with PaO2/FiO2 ≥ 200 → +5 (ratio) + 9 (ventilation) = 14', () {
      final r = compute(score, {
        ...zeroBaseline,
        'saps3-ventilated': true,
        'saps3-pao2_fio2': 5,
      });
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, '14 points');
    });
  });

  group('regression: surgical-admission toggle badge now matches its actual scoring effect', () {
    test('elective surgical admission = Yes → -6, matching the displayed badge', () {
      final r = compute(score, {...zeroBaseline, 'saps3-surgical': true});
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, '-6 points');
    });
  });

  group('regression: mortality equation uses the corrected intercept (-32.6659, not -36.0757)', () {
    test('a high total (95 points) predicts high mortality, not the ~17% the old buggy intercept would give', () {
      final r = compute(score, {
        'saps3-age': 18, // ≥80
        'saps3-ventilated': false,
        'saps3-location': 6, // ward
        'saps3-surgical': false,
        'saps3-reason': 10, // cardiac arrest
        'saps3-gcs': 15, // GCS 3
        'saps3-bilirubin': 6, // ≥9
        'saps3-temperature': 3, // ≥40
        'saps3-heart_rate': 7, // ≥160
        'saps3-map': 3, // ≥120
        'saps3-creatinine': 8, // ≥3.5
        'saps3-platelets': 13, // <20
        'saps3-wbc': 3, // ≥15
        'saps3-ph': 3, // ≥7.5
      });
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, '95 points');
      // Corrected intercept → ~88%; the pre-fix intercept (-36.0757) would
      // have produced ~17% for this same total — >50% clearly discriminates
      // the two without depending on exact floating-point precision.
      final pct = parsePercent(r.primaryInterpretation!);
      expect(pct, greaterThan(50));
    });

    test('total 0 → predicted mortality under 1 %', () {
      final r = compute(score, zeroBaseline);
      final pct = parsePercent(r.primaryInterpretation!);
      expect(pct, lessThan(1));
    });
  });

  test('German locale produces non-empty interpretation with no leaked keys', () {
    final de = buildSaps3Score('de');
    final r = compute(de, zeroBaseline);
    expect(r.state, ScoreState.success);
    expect(r.primaryInterpretation, isNotEmpty);
    expect(r.primaryInterpretation, isNot(contains('calc.')));
  });
}

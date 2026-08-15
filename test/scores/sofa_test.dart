import 'package:flutter_test/flutter_test.dart';
import 'package:scores_2_go/data/scores/definitions/sofa/sofa.dart';
import 'package:scores_2_go/model/model.dart';

import '../support/score_input.dart';

void main() {
  final score = buildSofaScore('en');

  test('nothing entered → incomplete', () {
    final r = compute(score, {});
    expect(r.state, ScoreState.incomplete);
  });

  test('renal satisfied by creatinine alone → complete', () {
    final r = compute(score, {
      'sofa-pao2_fio2': 0,
      'sofa-platelets': 0,
      'sofa-bilirubin': 0,
      'sofa-cardiovascular_status': 0,
      'sofa-gcs': 0,
      'sofa-creatinine': 0,
    });
    expect(r.state, ScoreState.success);
  });

  test('renal satisfied by urine output alone → complete', () {
    final r = compute(score, {
      'sofa-pao2_fio2': 0,
      'sofa-platelets': 0,
      'sofa-bilirubin': 0,
      'sofa-cardiovascular_status': 0,
      'sofa-gcs': 0,
      'sofa-urine_output': 0,
    });
    expect(r.state, ScoreState.success);
  });

  group('worked examples', () {
    test('Example A — renal creatinine and urine output agree → total 10/24', () {
      final r = compute(score, {
        'sofa-pao2_fio2': 2, // 250 mmHg → < 300
        'sofa-platelets': 2, // 90 → < 100
        'sofa-bilirubin': 2, // 3.0 mg/dL → 2.0–5.9
        'sofa-cardiovascular_status': 1, // MAP 60, no pressors
        'sofa-gcs': 1, // GCS 14
        'sofa-creatinine': 2, // 2.5 mg/dL → 2.0–3.4
        'sofa-urine_output': 0, // 800 mL/day → ≥ 500
      });
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, '10 points');
    });

    test('Example B — renal creatinine and urine output disagree, urine governs → total 21/24', () {
      final r = compute(score, {
        'sofa-pao2_fio2': 4, // 90 mmHg, on ventilation
        'sofa-respiratory_support': true,
        'sofa-platelets': 3, // 35 → < 50
        'sofa-bilirubin': 3, // 7.0 mg/dL → 6.0–11.9
        'sofa-cardiovascular_status': 4, // norepi 0.15 > 0.1
        'sofa-gcs': 3, // GCS 8
        'sofa-creatinine': 1, // 1.5 mg/dL → mild
        'sofa-urine_output': 4, // 150 mL/day → severe
      });
      expect(r.state, ScoreState.success);
      // Renal must take the worse (urine output, 4) over creatinine (1).
      expect(r.primaryResult, '21 points');
      expect(r.secondaryResult, contains('Renal 4'));
    });
  });

  group('respiratory support gate (regression: previously a dead toggle)', () {
    test('support explicitly "No" caps a <100mmHg selection at 2, not 4', () {
      final withSupport = compute(score, {
        'sofa-pao2_fio2': 4, // < 100 mmHg + respiratory support option
        'sofa-respiratory_support': true,
        'sofa-platelets': 0,
        'sofa-bilirubin': 0,
        'sofa-cardiovascular_status': 0,
        'sofa-gcs': 0,
        'sofa-creatinine': 0,
      });
      expect(withSupport.secondaryResult, contains('Resp 4'));

      final withoutSupport = compute(score, {
        'sofa-pao2_fio2': 4,
        'sofa-respiratory_support': false,
        'sofa-platelets': 0,
        'sofa-bilirubin': 0,
        'sofa-cardiovascular_status': 0,
        'sofa-gcs': 0,
        'sofa-creatinine': 0,
      });
      expect(withoutSupport.secondaryResult, contains('Resp 2'));
      expect(withoutSupport.primaryResult, '2 points');
    });

    test('support left unanswered still trusts the option label (unchanged prior behavior)', () {
      final r = compute(score, {
        'sofa-pao2_fio2': 3, // < 200 mmHg + respiratory support option
        'sofa-platelets': 0,
        'sofa-bilirubin': 0,
        'sofa-cardiovascular_status': 0,
        'sofa-gcs': 0,
        'sofa-creatinine': 0,
      });
      expect(r.secondaryResult, contains('Resp 3'));
    });

    test('support "No" does not affect a ≤2-point respiratory selection', () {
      final r = compute(score, {
        'sofa-pao2_fio2': 2, // < 300 mmHg, no support required at this band
        'sofa-respiratory_support': false,
        'sofa-platelets': 0,
        'sofa-bilirubin': 0,
        'sofa-cardiovascular_status': 0,
        'sofa-gcs': 0,
        'sofa-creatinine': 0,
      });
      expect(r.secondaryResult, contains('Resp 2'));
    });
  });

  group('mortality-risk interpretation bands (reconciled with landing page)', () {
    final cases = <int, String>{
      6: 'Very low risk',
      7: 'Low–moderate risk',
      9: 'Low–moderate risk',
      10: 'Moderate–high risk',
      12: 'Moderate–high risk',
      13: 'High risk',
      14: 'High risk',
      15: 'Very high risk',
    };

    cases.forEach((total, expectedPrefix) {
      test('total=$total → "$expectedPrefix"', () {
        // GCS 15=0, bilirubin band index chosen so all 6 sub-scores plus a
        // manufactured cardiovascular value sum to the target total, using
        // only the coagulation/liver/cardio/cns axes at 0 and driving the
        // total via respiration (capped 0-2 without support) and renal.
        // Simpler: drive entirely via cardiovascular_status (0-4) + renal
        // creatinine (0-4) + platelets (0-4), holding others at 0, to reach
        // arbitrary totals 0-12, and use bilirubin additionally for 13-15.
        final remaining = total;
        final cardio = remaining.clamp(0, 4);
        final afterCardio = remaining - cardio;
        final renal = afterCardio.clamp(0, 4);
        final afterRenal = afterCardio - renal;
        final plt = afterRenal.clamp(0, 4);
        final afterPlt = afterRenal - plt;
        final bili = afterPlt.clamp(0, 4);

        final r = compute(score, {
          'sofa-pao2_fio2': 0,
          'sofa-platelets': plt,
          'sofa-bilirubin': bili,
          'sofa-cardiovascular_status': cardio,
          'sofa-gcs': 0,
          'sofa-creatinine': renal,
        });
        expect(r.state, ScoreState.success);
        expect(r.primaryResult, '$total points');
        expect(r.primaryInterpretation, contains(expectedPrefix));
      });
    });
  });

  test('German locale produces non-empty interpretation with no leaked keys', () {
    final de = buildSofaScore('de');
    final r = compute(de, {
      'sofa-pao2_fio2': 0,
      'sofa-platelets': 0,
      'sofa-bilirubin': 0,
      'sofa-cardiovascular_status': 0,
      'sofa-gcs': 0,
      'sofa-creatinine': 0,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryInterpretation, isNotEmpty);
    expect(r.primaryInterpretation, isNot(contains('calc.risk')));
  });
}

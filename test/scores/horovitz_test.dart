import 'package:flutter_test/flutter_test.dart';
import 'package:scores_2_go/data/scores/definitions/horovitz/horovitz.dart';
import 'package:scores_2_go/model/model.dart';

import '../support/score_input.dart';

void main() {
  final score = buildHorovitzScore('en');

  test('nothing entered → incomplete', () {
    final r = compute(score, {});
    expect(r.state, ScoreState.incomplete);
  });

  test('PaO2 only → incomplete', () {
    final r = compute(score, {'horovitz-pao2': 80});
    expect(r.state, ScoreState.incomplete);
  });

  test('FiO2 only → incomplete', () {
    final r = compute(score, {'horovitz-fio2': 40});
    expect(r.state, ScoreState.incomplete);
  });

  test('PEEP absent must NOT block calculation — PaO2 + FiO2 alone succeeds', () {
    final r = compute(score, {'horovitz-pao2': 80, 'horovitz-fio2': 40});
    expect(r.state, ScoreState.success);
  });

  test('FiO2 = 0 → error, no division-by-zero', () {
    final r = compute(score, {'horovitz-pao2': 80, 'horovitz-fio2': 0});
    expect(r.state, ScoreState.error);
  });

  group('Berlin boundary regression (PEEP 8 → full Berlin label applies)', () {
    test('PaO2 80 / FiO2 40 → ratio 200 → Moderate ARDS (was wrongly Mild)', () {
      final r = compute(score, {
        'horovitz-pao2': 80,
        'horovitz-fio2': 40,
        'horovitz-peep': 8,
      });
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, '200 mmHg');
      expect(r.primaryInterpretation, contains('Moderate ARDS'));
      expect(r.primaryInterpretation, isNot(contains('Mild ARDS')));
    });

    test('PaO2 300 / FiO2 100 → ratio 300 → Mild ARDS (was wrongly mild hypoxemia)', () {
      final r = compute(score, {
        'horovitz-pao2': 300,
        'horovitz-fio2': 100,
        'horovitz-peep': 8,
      });
      expect(r.primaryResult, '300 mmHg');
      expect(r.primaryInterpretation, contains('Mild ARDS'));
    });

    test('PaO2 100 / FiO2 100 → ratio 100 → Severe ARDS (was wrongly Moderate)', () {
      final r = compute(score, {
        'horovitz-pao2': 100,
        'horovitz-fio2': 100,
        'horovitz-peep': 8,
      });
      expect(r.primaryResult, '100 mmHg');
      expect(r.primaryInterpretation, contains('Severe ARDS'));
    });
  });

  group('mid-band sanity', () {
    test('PaO2 60 / FiO2 100 → ratio 60 → Severe', () {
      final r = compute(score, {
        'horovitz-pao2': 60,
        'horovitz-fio2': 100,
        'horovitz-peep': 8,
      });
      expect(r.primaryResult, '60 mmHg');
      expect(r.primaryInterpretation, contains('Severe ARDS'));
    });

    test('PaO2 400 / FiO2 100 → ratio 400 → normal', () {
      final r = compute(score, {
        'horovitz-pao2': 400,
        'horovitz-fio2': 100,
      });
      expect(r.primaryResult, '400 mmHg');
      expect(r.primaryInterpretation, contains('Normal'));
    });
  });

  // A PaO2 entered as 9.3 kPa is stored as 9.3 / 0.133322 ≈ 69.76 mmHg, since
  // mmHg is the canonical unit of Units.pressure. This asserts the function
  // treats its input as already-canonical mmHg and applies no unit maths of its
  // own — a second conversion here would yield ~1047 and read as "Normal".
  // Note the test harness sets `value` directly, so this pins the function's
  // contract, not the UI's conversion widget.
  test('PaO2 9.3 kPa (≈69.76 mmHg canonical) / FiO2 50 % → 140, Moderate', () {
    final r = compute(score, {
      'horovitz-pao2': 9.3 / 0.133322,
      'horovitz-fio2': 50,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '140 mmHg');
    expect(r.primaryInterpretation, contains('Moderate ARDS range'));
    expect(r.primaryInterpretation, contains('additionally requires'));
  });

  test(
    'rounding consistency: displayed integer and band always agree at a near-boundary value',
    () {
      // True ratio = 80.2 / 0.4 = 200.5 → rounds to 201 (Dart .round() rounds
      // halves away from zero / up), which must be labelled Mild ARDS, not
      // Moderate, and the displayed number must match the interpreted value.
      final r = compute(score, {
        'horovitz-pao2': 80.2,
        'horovitz-fio2': 40,
        'horovitz-peep': 8,
      });
      expect(r.state, ScoreState.success);
      final displayed = int.parse(r.primaryResult!.split(' ').first);
      expect(displayed, 201);
      expect(r.primaryInterpretation, contains('Mild ARDS'));
      expect(r.primaryInterpretation, isNot(contains('Moderate ARDS')));
    },
  );

  group('PEEP gating on an ARDS-range ratio (P/F 150)', () {
    test('PEEP 8 (≥5) → full Berlin assertion', () {
      final r = compute(score, {
        'horovitz-pao2': 150,
        'horovitz-fio2': 100,
        'horovitz-peep': 8,
      });
      expect(r.primaryInterpretation, contains('Moderate ARDS — Berlin Definition'));
    });

    test('PEEP 3 (<5) → hedge / non-applicability wording, not a bare Berlin assertion', () {
      final r = compute(score, {
        'horovitz-pao2': 150,
        'horovitz-fio2': 100,
        'horovitz-peep': 3,
      });
      expect(r.primaryInterpretation, contains('Moderate ARDS range'));
      expect(r.primaryInterpretation, contains('does not apply'));
      expect(
        r.primaryInterpretation,
        isNot(contains('Moderate ARDS — Berlin Definition')),
      );
    });

    test('PEEP absent → hedged label, not a bare Berlin assertion', () {
      final r = compute(score, {
        'horovitz-pao2': 150,
        'horovitz-fio2': 100,
      });
      expect(r.primaryInterpretation, contains('Moderate ARDS range'));
      expect(r.primaryInterpretation, contains('additionally requires'));
      expect(
        r.primaryInterpretation,
        isNot(contains('Moderate ARDS — Berlin Definition')),
      );
    });
  });

  test('no ARDS wording above 300 even with PEEP ≥ 5', () {
    final r = compute(score, {
      'horovitz-pao2': 350,
      'horovitz-fio2': 100,
      'horovitz-peep': 10,
    });
    expect(r.primaryInterpretation, isNot(contains('ARDS')));
  });

  test('secondary row appends PEEP only when entered', () {
    final withPeep = compute(score, {
      'horovitz-pao2': 80,
      'horovitz-fio2': 40,
      'horovitz-peep': 8,
    });
    expect(withPeep.secondaryResult, 'PaO₂ 80 mmHg · FiO₂ 40 % · PEEP 8 cmH₂O');

    final withoutPeep = compute(score, {
      'horovitz-pao2': 80,
      'horovitz-fio2': 40,
    });
    expect(withoutPeep.secondaryResult, 'PaO₂ 80 mmHg · FiO₂ 40 %');
  });

  test('German locale produces non-empty interpretation with no leaked English', () {
    final de = buildHorovitzScore('de');
    final r = compute(de, {
      'horovitz-pao2': 80,
      'horovitz-fio2': 40,
      'horovitz-peep': 8,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryInterpretation, isNotEmpty);
    expect(r.primaryInterpretation, contains('Moderates ARDS'));
    expect(r.primaryInterpretation, isNot(contains('Moderate ARDS')));
    // No untranslated i10n key artefacts (e.g. "calc.interp." leaking through).
    expect(r.primaryInterpretation, isNot(contains('calc.interp')));
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:scores_2_go/data/scores/definitions/gcs/gcs.dart';
import 'package:scores_2_go/model/model.dart';

import '../support/score_input.dart';

// Sentinel stored in the "not testable" option's value.
const nt = -1;

void main() {
  final score = buildGcsScore('en');

  test('nothing answered → incomplete', () {
    final r = compute(score, {});
    expect(r.state, ScoreState.incomplete);
  });

  test('only some subscales answered → incomplete', () {
    final r = compute(score, {'gcs-eyes': 4, 'gcs-verbal': nt});
    expect(r.state, ScoreState.incomplete);
  });

  test('E3 V4 M5 → 12 / 15, moderate', () {
    final r = compute(score, {
      'gcs-eyes': 3,
      'gcs-verbal': 4,
      'gcs-motor': 5,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '12 / 15');
    expect(r.primaryInterpretation, contains('Moderate'));
    expect(r.secondaryResult, 'E3 V4 M5');
  });

  test('E1 V1 M1 → 3 / 15, severe', () {
    final r = compute(score, {
      'gcs-eyes': 1,
      'gcs-verbal': 1,
      'gcs-motor': 1,
    });
    expect(r.primaryResult, '3 / 15');
    expect(r.primaryInterpretation, contains('Severe'));
  });

  test('E4 V5 M6 → 15 / 15, mild', () {
    final r = compute(score, {
      'gcs-eyes': 4,
      'gcs-verbal': 5,
      'gcs-motor': 6,
    });
    expect(r.primaryResult, '15 / 15');
    expect(r.primaryInterpretation, contains('Mild'));
  });

  // Regression: an intubated patient (E4 VNT M6) used to render as
  // "10 / 10 — Moderate — GCS 9–12", labelling a near-normal patient as a
  // moderate brain injury. The official Glasgow structured approach says not to
  // report a total at all when a component is Not Testable.
  group('not testable', () {
    test('E4 VNT M6 → components only, no total, no severity band', () {
      final r = compute(score, {
        'gcs-eyes': 4,
        'gcs-verbal': nt,
        'gcs-motor': 6,
      });
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, 'E4 VNT M6');
      expect(r.primaryInterpretation, isNot(contains('Mild')));
      expect(r.primaryInterpretation, isNot(contains('Moderate')));
      expect(r.primaryInterpretation, isNot(contains('Severe')));
      expect(r.primaryInterpretation, isNot(contains('/ 15')));
      expect(r.primaryInterpretation, isNot(contains('10')));
    });

    test('all three NT → no crash, components only', () {
      final r = compute(score, {
        'gcs-eyes': nt,
        'gcs-verbal': nt,
        'gcs-motor': nt,
      });
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, 'ENT VNT MNT');
      expect(r.primaryInterpretation, isNotEmpty);
    });

    test('the NT sentinel never leaks into displayed output', () {
      for (final picks in [
        {'gcs-eyes': nt, 'gcs-verbal': 5, 'gcs-motor': 6},
        {'gcs-eyes': 4, 'gcs-verbal': nt, 'gcs-motor': 6},
        {'gcs-eyes': 4, 'gcs-verbal': 5, 'gcs-motor': nt},
      ]) {
        final r = compute(score, picks);
        expect(r.primaryResult, isNot(contains('-1')));
        expect(r.primaryInterpretation, isNot(contains('-1')));
      }
    });

    test('German multi-NT list has no Oxford comma before "und"', () {
      final de = buildGcsScore('de');
      final r = compute(de, {
        'gcs-eyes': nt,
        'gcs-verbal': nt,
        'gcs-motor': nt,
      });
      expect(r.primaryInterpretation, isNot(contains(', und ')));
      expect(r.primaryInterpretation, contains(' und '));
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:scores_2_go/data/scores/definitions/finnegan/finnegan.dart';
import 'package:scores_2_go/model/model.dart';

import '../support/score_input.dart';

/// All 21 items answered at their zero-point level.
Map<String, Object?> allNormal() => {
  'finnegan-cry': 0,
  'finnegan-sleep': 0,
  'finnegan-moro': 0,
  'finnegan-tremors': 0,
  'finnegan-muscle-tone': false,
  'finnegan-excoriation': false,
  'finnegan-myoclonic-jerks': false,
  'finnegan-convulsions': false,
  'finnegan-sweating': false,
  'finnegan-fever': 0,
  'finnegan-yawning': false,
  'finnegan-mottling': false,
  'finnegan-nasal-stuffiness': false,
  'finnegan-sneezing': false,
  'finnegan-nasal-flaring': false,
  'finnegan-respiratory-rate': 0,
  'finnegan-sucking': false,
  'finnegan-feeding': false,
  'finnegan-regurgitation': false,
  'finnegan-vomiting': false,
  'finnegan-stools': 0,
};

/// All 21 items answered at their maximum-point level.
Map<String, Object?> allMax() => {
  'finnegan-cry': 3,
  'finnegan-sleep': 3,
  'finnegan-moro': 3,
  'finnegan-tremors': 4,
  'finnegan-muscle-tone': true,
  'finnegan-excoriation': true,
  'finnegan-myoclonic-jerks': true,
  'finnegan-convulsions': true,
  'finnegan-sweating': true,
  'finnegan-fever': 2,
  'finnegan-yawning': true,
  'finnegan-mottling': true,
  'finnegan-nasal-stuffiness': true,
  'finnegan-sneezing': true,
  'finnegan-nasal-flaring': true,
  'finnegan-respiratory-rate': 2,
  'finnegan-sucking': true,
  'finnegan-feeding': true,
  'finnegan-regurgitation': true,
  'finnegan-vomiting': true,
  'finnegan-stools': 3,
};

void main() {
  final score = buildFinneganScore('en');

  test('the score collects exactly the canonical 21 items', () {
    final names = score.groups
        .expand((g) => g.items)
        .map((v) => v.name)
        .toList();
    expect(names, hasLength(21));
    expect(names.toSet(), hasLength(21), reason: 'variable names must be unique');
  });

  test('nothing answered → incomplete', () {
    final r = compute(score, {});
    expect(r.state, ScoreState.incomplete);
  });

  test('partially answered → incomplete, with running total', () {
    final r = compute(score, {'finnegan-cry': 3, 'finnegan-sleep': 3});
    expect(r.state, ScoreState.incomplete);
    expect(r.primaryResult, '6 / 46');
  });

  test('all items normal → 0 / 46, mild', () {
    final r = compute(score, allNormal());
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '0 / 46');
    expect(r.primaryInterpretation, contains('Mild'));
  });

  // Regression: tremors and respiratory-rate/retractions were each split into
  // two additive items, so the theoretical max was 50 rather than the
  // canonical 46 and both were double counted.
  test('all items at maximum → exactly 46, never above', () {
    final r = compute(score, allMax());
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '46 / 46');
    expect(r.secondaryResult, '24 / 11 / 11');
  });

  test('worked example A → 5 / 46, mild', () {
    final r = compute(score, {
      ...allNormal(),
      'finnegan-cry': 2,
      'finnegan-sleep': 1,
      'finnegan-tremors': 1,
      'finnegan-sucking': true,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '5 / 46');
    expect(r.primaryInterpretation, contains('Mild'));
  });

  test('worked example B → 20 / 46, severe', () {
    final r = compute(score, {
      ...allNormal(),
      'finnegan-cry': 3,
      'finnegan-sleep': 3,
      'finnegan-moro': 2,
      'finnegan-tremors': 3,
      'finnegan-muscle-tone': true,
      'finnegan-sweating': true,
      'finnegan-nasal-stuffiness': true,
      'finnegan-sucking': true,
      'finnegan-feeding': true,
      'finnegan-stools': 2,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '20 / 46');
    expect(r.primaryInterpretation, contains('Severe'));
  });

  // Band edges: < 8 mild, 8–11 moderate, >= 12 severe.
  test('band boundaries at 7/8 and 11/12', () {
    void expectBand(int expected, Map<String, Object?> picks, String band) {
      final r = compute(score, {...allNormal(), ...picks});
      expect(r.primaryResult, '$expected / 46');
      expect(r.primaryInterpretation, contains(band));
    }

    // 7 is the last mild score, 8 the first moderate.
    expectBand(7, {'finnegan-convulsions': true, 'finnegan-tremors': 2}, 'Mild');
    expectBand(
      8,
      {'finnegan-convulsions': true, 'finnegan-tremors': 3},
      'Moderate',
    );

    // 11 is the last moderate score, 12 the first severe.
    expectBand(
      11,
      {
        'finnegan-convulsions': true,
        'finnegan-tremors': 3,
        'finnegan-moro': 3,
      },
      'Moderate',
    );
    expectBand(
      12,
      {
        'finnegan-convulsions': true,
        'finnegan-tremors': 4,
        'finnegan-cry': 3,
      },
      'Severe',
    );
  });
}

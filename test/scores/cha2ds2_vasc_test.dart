import 'package:flutter_test/flutter_test.dart';
import 'package:scores_2_go/data/scores/definitions/cha2ds2-vasc/cha2ds2_vasc.dart';
import 'package:scores_2_go/model/model.dart';

import '../support/score_input.dart';

void main() {
  final score = buildCha2ds2VascScore('en');

  // All seven risk factors negative / lowest option, for a given sex.
  Map<String, Object?> baseline({required int sex}) => {
        'cha2ds2-vasc-chf': false,
        'cha2ds2-vasc-hypertension': false,
        'cha2ds2-vasc-age': 0,
        'cha2ds2-vasc-diabetes': false,
        'cha2ds2-vasc-stroke-tia': false,
        'cha2ds2-vasc-vascular-disease': false,
        'cha2ds2-vasc-sex': sex, // 1 = female, 0 = male
      };

  test('missing a factor → incomplete', () {
    final input = baseline(sex: 0)..remove('cha2ds2-vasc-sex');
    expect(compute(score, input).state, ScoreState.incomplete);
  });

  test('male, all negative → 0/9, no therapy, 0.2% risk', () {
    final r = compute(score, baseline(sex: 0));
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '0 / 9');
    expect(r.primaryInterpretation, contains('No antithrombotic therapy'));
    expect(r.secondaryResult, '0.2% per year');
  });

  test('male score 1 → "may be considered"', () {
    final r = compute(score, baseline(sex: 0)..['cha2ds2-vasc-age'] = 1);
    expect(r.primaryResult, '1 / 9');
    expect(r.primaryInterpretation, contains('may be considered'));
    expect(r.secondaryResult, '0.6% per year');
  });

  test('male score 2 → anticoagulation recommended', () {
    final r = compute(score, baseline(sex: 0)
      ..['cha2ds2-vasc-chf'] = true
      ..['cha2ds2-vasc-age'] = 1);
    expect(r.primaryResult, '2 / 9');
    expect(r.primaryInterpretation, contains('recommended'));
    expect(r.secondaryResult, '2.2% per year');
  });

  test('female with only the sex point (score 1) → no therapy', () {
    // A woman with no other risk factors should not get OAC.
    final r = compute(score, baseline(sex: 1));
    expect(r.primaryResult, '1 / 9');
    expect(r.primaryInterpretation, contains('No antithrombotic therapy'));
  });

  test('female score 2 → "may be considered"', () {
    final r = compute(score, baseline(sex: 1)..['cha2ds2-vasc-chf'] = true);
    expect(r.primaryResult, '2 / 9');
    expect(r.primaryInterpretation, contains('may be considered'));
  });

  test('female score 3 (prior stroke) → recommended', () {
    final r = compute(score, baseline(sex: 1)..['cha2ds2-vasc-stroke-tia'] = true);
    expect(r.primaryResult, '3 / 9');
    expect(r.primaryInterpretation, contains('recommended'));
    expect(r.secondaryResult, '3.2% per year');
  });

  test('maximum score → 9/9', () {
    final r = compute(score, {
      'cha2ds2-vasc-chf': true,
      'cha2ds2-vasc-hypertension': true,
      'cha2ds2-vasc-age': 2,
      'cha2ds2-vasc-diabetes': true,
      'cha2ds2-vasc-stroke-tia': true,
      'cha2ds2-vasc-vascular-disease': true,
      'cha2ds2-vasc-sex': 1,
    });
    expect(r.primaryResult, '9 / 9');
    expect(r.secondaryResult, '12.2% per year');
  });
}

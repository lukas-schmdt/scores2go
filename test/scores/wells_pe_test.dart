import 'package:flutter_test/flutter_test.dart';
import 'package:scores_2_go/data/scores/definitions/wells-pe/wells_pe.dart';
import 'package:scores_2_go/model/model.dart';

import '../support/score_input.dart';

const _all = [
  'wells-pe-dvt-signs',
  'wells-pe-pe-likely',
  'wells-pe-heart-rate',
  'wells-pe-immobilization-surgery',
  'wells-pe-previous-vte',
  'wells-pe-hemoptysis',
  'wells-pe-malignancy',
];

/// Builds a fully answered input map where only [positive] items are true.
Map<String, Object?> _answers(Set<String> positive) => {
  for (final n in _all) n: positive.contains(n),
};

void main() {
  final score = buildWellsPeScore('en');

  test('nothing answered → incomplete', () {
    expect(compute(score, {}).state, ScoreState.incomplete);
  });

  test('partially answered → incomplete', () {
    final r = compute(score, {'wells-pe-heart-rate': true});
    expect(r.state, ScoreState.incomplete);
  });

  void check(
    String name,
    Set<String> positive,
    String total,
    String tier,
    bool likely,
  ) {
    test(name, () {
      final r = compute(score, _answers(positive));
      expect(r.state, ScoreState.success);
      expect(r.primaryResult, '$total / 12.5');
      expect(r.secondaryResult, tier);
      expect(
        r.primaryInterpretation,
        contains(likely ? 'PE likely' : 'PE unlikely'),
      );
    });
  }

  check('A none → 0, low, unlikely', {}, '0', 'Low', false);
  check(
    'B HR only → 1.5, low, unlikely',
    {'wells-pe-heart-rate'},
    '1.5',
    'Low',
    false,
  );
  check(
    'C hemoptysis+malignancy → 2, moderate, unlikely',
    {'wells-pe-hemoptysis', 'wells-pe-malignancy'},
    '2',
    'Moderate',
    false,
  );
  check(
    'D HR+immobilization+hemoptysis → 4, moderate, unlikely',
    {
      'wells-pe-heart-rate',
      'wells-pe-immobilization-surgery',
      'wells-pe-hemoptysis',
    },
    '4',
    'Moderate',
    false,
  );
  check(
    'E HR+immobilization+previous VTE → 4.5, moderate, likely',
    {
      'wells-pe-heart-rate',
      'wells-pe-immobilization-surgery',
      'wells-pe-previous-vte',
    },
    '4.5',
    'Moderate',
    true,
  );
  check(
    'F PE#1+HR+previous VTE → 6, moderate, likely',
    {'wells-pe-pe-likely', 'wells-pe-heart-rate', 'wells-pe-previous-vte'},
    '6',
    'Moderate',
    true,
  );
  check(
    'G PE#1+HR+hemoptysis+malignancy → 6.5, high, likely',
    {
      'wells-pe-pe-likely',
      'wells-pe-heart-rate',
      'wells-pe-hemoptysis',
      'wells-pe-malignancy',
    },
    '6.5',
    'High',
    true,
  );
  check('H all → 12.5, high, likely', _all.toSet(), '12.5', 'High', true);

  test('German locale uses comma decimal and German text', () {
    final r = compute(
      buildWellsPeScore('de'),
      _answers({
        'wells-pe-heart-rate',
        'wells-pe-immobilization-surgery',
        'wells-pe-previous-vte',
      }),
    );
    expect(r.primaryResult, '4,5 / 12,5');
    expect(r.primaryInterpretation, contains('LE wahrscheinlich'));
    expect(r.secondaryResult, 'Mittel');
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:scores_2_go/data/scores/definitions/wells-dvt/wells_dvt.dart';
import 'package:scores_2_go/model/model.dart';

import '../support/score_input.dart';

const _cancer = 'wells-dvt-cancer';
const _paralysis = 'wells-dvt-paralysis';
const _bedridden = 'wells-dvt-bedridden-surgery';
const _tenderness = 'wells-dvt-tenderness';
const _entireLeg = 'wells-dvt-entire-leg-swollen';
const _calf = 'wells-dvt-calf-swelling';
const _pitting = 'wells-dvt-pitting-edema';
const _collateral = 'wells-dvt-collateral-veins';
const _previous = 'wells-dvt-previous-dvt';
const _altDx = 'wells-dvt-alternative-diagnosis';

const _all = [
  _cancer,
  _paralysis,
  _bedridden,
  _tenderness,
  _entireLeg,
  _calf,
  _pitting,
  _collateral,
  _previous,
  _altDx,
];

/// Builds a fully answered input map where only [positive] items are true.
Map<String, Object?> _answers(Set<String> positive) => {
  for (final n in _all) n: positive.contains(n),
};

void main() {
  final score = buildWellsDvtScore('en');

  test('nothing answered → incomplete', () {
    expect(compute(score, {}).state, ScoreState.incomplete);
  });

  test('partially answered → incomplete', () {
    expect(compute(score, {_tenderness: true}).state, ScoreState.incomplete);
  });

  test('all but alternative diagnosis answered → incomplete', () {
    final answers = _answers({_tenderness})..remove(_altDx);
    expect(compute(score, answers).state, ScoreState.incomplete);
  });

  test('only alternative diagnosis unanswered null → incomplete', () {
    final answers = _answers({})..[_altDx] = null;
    expect(compute(score, answers).state, ScoreState.incomplete);
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
      expect(r.primaryResult, '$total / 9');
      expect(r.secondaryResult, tier);
      expect(
        r.primaryInterpretation,
        contains(likely ? 'DVT likely' : 'DVT unlikely'),
      );
    });
  }

  check('A alt-dx only → −2, low, unlikely', {_altDx}, '−2', 'Low', false);
  check('B none → 0, low, unlikely', {}, '0', 'Low', false);
  check(
    'C tenderness only → 1, moderate, unlikely',
    {_tenderness},
    '1',
    'Moderate',
    false,
  );
  check(
    'D cancer+entire leg → 2, moderate, likely',
    {_cancer, _entireLeg},
    '2',
    'Moderate',
    true,
  );
  check(
    'E tenderness+pitting+calf → 3, high, likely',
    {_tenderness, _pitting, _calf},
    '3',
    'High',
    true,
  );
  check(
    'F E + alt-dx → 1, moderate, unlikely',
    {_tenderness, _pitting, _calf, _altDx},
    '1',
    'Moderate',
    false,
  );
  check(
    'G all nine +1 items → 9, high, likely',
    _all.where((n) => n != _altDx).toSet(),
    '9',
    'High',
    true,
  );

  test('German locale uses German text', () {
    final r = compute(
      buildWellsDvtScore('de'),
      _answers({_cancer, _entireLeg}),
    );
    expect(r.primaryResult, '2 / 9');
    expect(r.primaryInterpretation, contains('TVT wahrscheinlich'));
    expect(r.secondaryResult, 'Mittel');
  });

  test('German locale shows negative total', () {
    final r = compute(buildWellsDvtScore('de'), _answers({_altDx}));
    expect(r.primaryResult, '−2 / 9');
    expect(r.primaryInterpretation, contains('TVT unwahrscheinlich'));
    expect(r.secondaryResult, 'Niedrig');
  });
}

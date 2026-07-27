import 'package:flutter_test/flutter_test.dart';
import 'package:scores_2_go/data/scores/definitions/icdsc/icdsc.dart';
import 'package:scores_2_go/data/scores/definitions/icdsc/icdsc_visibility.dart';
import 'package:scores_2_go/model/model.dart';

import '../support/score_input.dart';

/// LOC option values as defined in `icdsc.dart`. A and B share the sentinel
/// -1 ("assessment halted"); C and E both score 1.
const _locNotAssessable = -1;
const _locDrowsy = 1; // C
const _locNormal = 0; // D
const _locAgitated = 1; // E

/// Items 2–8, all rated absent.
const _allItemsAbsent = {
  'icdsc-inattention': false,
  'icdsc-disorientation': false,
  'icdsc-hallucinations': false,
  'icdsc-psychomotor': false,
  'icdsc-speech-mood': false,
  'icdsc-sleep-wake': false,
  'icdsc-fluctuation': false,
};

void main() {
  final score = buildIcdscScore('en');

  test('nothing rated → incomplete', () {
    final r = compute(score, {});
    expect(r.state, ScoreState.incomplete);
  });

  test('LOC rated but items 2–8 unanswered → incomplete', () {
    final r = compute(score, {'icdsc-loc': _locNormal});
    expect(r.state, ScoreState.incomplete);
  });

  test('LOC rated, items partially answered → incomplete', () {
    final r = compute(score, {
      'icdsc-loc': _locNormal,
      'icdsc-inattention': true,
      'icdsc-disorientation': false,
    });
    expect(r.state, ScoreState.incomplete);
  });

  test('example A: LOC E + 5 items present → 6 / 8, delirium', () {
    final r = compute(score, {
      'icdsc-loc': _locAgitated,
      'icdsc-inattention': true,
      'icdsc-disorientation': true,
      'icdsc-hallucinations': true,
      'icdsc-psychomotor': true,
      'icdsc-speech-mood': false,
      'icdsc-sleep-wake': true,
      'icdsc-fluctuation': false,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '6 / 8');
    expect(r.primaryInterpretation, contains('Delirium'));
  });

  test('example B: LOC D + all items absent → 0 / 8, no delirium', () {
    final r = compute(score, {
      'icdsc-loc': _locNormal,
      ..._allItemsAbsent,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '0 / 8');
    expect(r.primaryInterpretation, contains('No delirium'));
  });

  test('example C1: LOC A/B → not assessable, never a numeric total', () {
    final r = compute(score, {'icdsc-loc': _locNotAssessable});
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, 'Not assessable');
    expect(r.primaryResult, isNot(contains('/')));
  });

  test('example C1: stale item answers cannot leak into an A/B result', () {
    final r = compute(score, {
      'icdsc-loc': _locNotAssessable,
      'icdsc-inattention': true,
      'icdsc-disorientation': true,
      'icdsc-hallucinations': true,
      'icdsc-psychomotor': true,
      'icdsc-speech-mood': true,
      'icdsc-sleep-wake': true,
      'icdsc-fluctuation': true,
    });
    expect(r.primaryResult, 'Not assessable');
  });

  test('example C2: LOC C + 2 items present → 3 / 8, subsyndromal', () {
    final r = compute(score, {
      'icdsc-loc': _locDrowsy,
      'icdsc-inattention': true,
      'icdsc-disorientation': false,
      'icdsc-hallucinations': false,
      'icdsc-psychomotor': false,
      'icdsc-speech-mood': false,
      'icdsc-sleep-wake': true,
      'icdsc-fluctuation': false,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '3 / 8');
    expect(r.primaryInterpretation, contains('Subsyndromal'));
  });

  test('4 points is the delirium threshold, 3 is not', () {
    ScoreResult at(int extraItems) => compute(score, {
          'icdsc-loc': _locNormal,
          ..._allItemsAbsent,
          'icdsc-inattention': extraItems >= 1,
          'icdsc-disorientation': extraItems >= 2,
          'icdsc-hallucinations': extraItems >= 3,
          'icdsc-psychomotor': extraItems >= 4,
        });
    expect(at(3).primaryResult, '3 / 8');
    expect(at(3).primaryInterpretation, contains('Subsyndromal'));
    expect(at(4).primaryResult, '4 / 8');
    expect(at(4).primaryInterpretation, contains('Delirium'));
  });

  test('maximum total is 8', () {
    final r = compute(score, {
      'icdsc-loc': _locAgitated,
      'icdsc-inattention': true,
      'icdsc-disorientation': true,
      'icdsc-hallucinations': true,
      'icdsc-psychomotor': true,
      'icdsc-speech-mood': true,
      'icdsc-sleep-wake': true,
      'icdsc-fluctuation': true,
    });
    expect(r.primaryResult, '8 / 8');
  });

  test('visibility hides items 2–8 only when LOC is A/B', () {
    final halted = icdscVisibility(
      withValues(score, {'icdsc-loc': _locNotAssessable}),
    );
    expect(halted.activeVariableNames, contains('icdsc-loc'));
    expect(halted.activeVariableNames, isNot(contains('icdsc-inattention')));
    expect(halted.activeVariableNames, isNot(contains('icdsc-fluctuation')));

    final open = icdscVisibility(withValues(score, {'icdsc-loc': _locNormal}));
    expect(open.activeVariableNames, contains('icdsc-inattention'));
    expect(open.activeVariableNames, contains('icdsc-fluctuation'));
  });

  test('German locale computes the same totals', () {
    final de = buildIcdscScore('de');
    final r = compute(de, {
      'icdsc-loc': _locDrowsy,
      'icdsc-inattention': true,
      'icdsc-disorientation': false,
      'icdsc-hallucinations': false,
      'icdsc-psychomotor': false,
      'icdsc-speech-mood': false,
      'icdsc-sleep-wake': true,
      'icdsc-fluctuation': false,
    });
    expect(r.state, ScoreState.success);
    expect(r.primaryResult, '3 / 8');
  });
}

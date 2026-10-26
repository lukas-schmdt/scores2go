import 'package:scores_2_go/data/scores/definitions/wells-dvt/wells_dvt_i10n.dart';
import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final _i10n = WellsDvtI10n();

const _variableNames = [
  'wells-dvt-cancer',
  'wells-dvt-paralysis',
  'wells-dvt-bedridden-surgery',
  'wells-dvt-tenderness',
  'wells-dvt-entire-leg-swollen',
  'wells-dvt-calf-swelling',
  'wells-dvt-pitting-edema',
  'wells-dvt-collateral-veins',
  'wells-dvt-previous-dvt',
  'wells-dvt-alternative-diagnosis',
];

ScoreResult wellsDvtFunction(Score score, String lang) {
  String t(String key) => _i10n.t(lang, key);
  final ctx = FlatScoreContext(score: score);

  int total = 0;
  for (final name in _variableNames) {
    final pts = ctx.boolValue(name)?['points'] as num?;
    if (pts == null) {
      return ScoreResult.incomplete(
        label: t('calc.label'),
        interpretation: t('calc.incomplete'),
      );
    }
    total += pts.toInt();
  }

  final String tier;
  if (total <= 0) {
    tier = 'low';
  } else if (total <= 2) {
    tier = 'moderate';
  } else {
    tier = 'high';
  }

  // U+2212 minus sign for negative totals.
  final shown = total < 0 ? '−${-total}' : '$total';

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: t('calc.label'),
    primaryResult: '$shown / 9',
    primaryInterpretation: total <= 1 ? t('calc.unlikely') : t('calc.likely'),
    secondaryLabel: t('calc.secondaryLabel'),
    secondaryResult: t('calc.tier.$tier'),
    secondaryInterpretation: t('calc.tier.$tier.interp'),
  );
}

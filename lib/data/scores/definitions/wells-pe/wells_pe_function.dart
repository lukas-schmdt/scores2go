import 'package:scores_2_go/data/scores/definitions/wells-pe/wells_pe_i10n.dart';
import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final _i10n = WellsPeI10n();

const _variableNames = [
  'wells-pe-dvt-signs',
  'wells-pe-pe-likely',
  'wells-pe-heart-rate',
  'wells-pe-immobilization-surgery',
  'wells-pe-previous-vte',
  'wells-pe-hemoptysis',
  'wells-pe-malignancy',
];

ScoreResult wellsPeFunction(Score score, String lang) {
  String t(String key) => _i10n.t(lang, key);
  final ctx = FlatScoreContext(score: score);

  double total = 0;
  for (final name in _variableNames) {
    final pts = ctx.boolValue(name)?['points'] as num?;
    if (pts == null) {
      return ScoreResult.incomplete(
        label: t('calc.label'),
        interpretation: t('calc.incomplete'),
      );
    }
    total += pts.toDouble();
  }

  final String tier;
  if (total < 2) {
    tier = 'low';
  } else if (total <= 6) {
    tier = 'moderate';
  } else {
    tier = 'high';
  }

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: t('calc.label'),
    primaryResult: '${_fmt(total, lang)} / ${_fmt(12.5, lang)}',
    primaryInterpretation: total <= 4 ? t('calc.unlikely') : t('calc.likely'),
    secondaryLabel: t('calc.secondaryLabel'),
    secondaryResult: t('calc.tier.$tier'),
    secondaryInterpretation: t('calc.tier.$tier.interp'),
  );
}

/// Whole numbers without decimals, half points with one decimal
/// (comma in German).
String _fmt(double v, String lang) {
  final s = v == v.roundToDouble()
      ? v.toInt().toString()
      : v.toStringAsFixed(1);
  return lang == 'de' ? s.replaceFirst('.', ',') : s;
}

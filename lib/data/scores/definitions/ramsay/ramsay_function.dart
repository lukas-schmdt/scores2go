import 'package:scores_2_go/data/scores/definitions/ramsay/ramsay_i10n.dart';
import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final _i10n = RamsayI10n();

ScoreResult ramsayFunction(Score score, String lang) {
  String t(String key) => _i10n.t(lang, key);
  final ctx = FlatScoreContext(score: score);
  final level = ctx.singleSelect('ramsay-level')?['value'] as num?;

  if (level == null) {
    return ScoreResult.incomplete(
      label: t('display'),
      interpretation: t('calc.incomplete'),
    );
  }

  final value = level.toInt();
  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: t('level.display'),
    primaryResult: '${t('calc.levelResult')} $value',
    primaryInterpretation: _interpretation(value, t),
    secondaryLabel: t('calc.secondaryLabel'),
    secondaryResult: _rating(value, t),
  );
}

String _interpretation(int v, String Function(String) t) => switch (v) {
      1 => t('calc.interp.1'),
      2 => t('calc.interp.2'),
      3 => t('calc.interp.3'),
      4 => t('calc.interp.4'),
      5 => t('calc.interp.5'),
      6 => t('calc.interp.6'),
      _ => '',
    };

String _rating(int v, String Function(String) t) => switch (v) {
      1 => t('calc.rating.1'),
      2 || 3 => t('calc.rating.2_3'),
      4 || 5 => t('calc.rating.4_5'),
      6 => t('calc.rating.6'),
      _ => '',
    };

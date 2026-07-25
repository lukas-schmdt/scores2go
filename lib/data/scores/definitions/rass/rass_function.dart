import 'package:scores_2_go/data/scores/definitions/rass/rass_i10n.dart';
import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final _i10n = RassI10n();

ScoreResult rassFunction(Score score, String lang) {
  String t(String key) => _i10n.t(lang, key);
  final ctx = FlatScoreContext(score: score);
  final level = ctx.singleSelect('rass-level')?['value'] as num?;

  if (level == null) {
    return ScoreResult.incomplete(
      label: t('display'),
      interpretation: t('calc.incomplete'),
    );
  }

  final value = level.toInt();
  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: t('display'),
    primaryResult: value > 0 ? '+$value' : '$value',
    primaryInterpretation: _interpretation(value, t),
  );
}

String _interpretation(int v, String Function(String) t) => switch (v) {
      4 => t('calc.interp.plus4'),
      3 => t('calc.interp.plus3'),
      2 => t('calc.interp.plus2'),
      1 => t('calc.interp.plus1'),
      0 => t('calc.interp.zero'),
      -1 => t('calc.interp.minus1'),
      -2 => t('calc.interp.minus2'),
      -3 => t('calc.interp.minus3'),
      -4 => t('calc.interp.minus4'),
      -5 => t('calc.interp.minus5'),
      _ => '',
    };

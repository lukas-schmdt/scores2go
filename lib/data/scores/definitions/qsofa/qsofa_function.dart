import 'package:scores_2_go/data/scores/definitions/qsofa/qsofa_i10n.dart';
import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

final _i10n = QsofaI10n();

ScoreResult qsofaFunction(Score score, String lang) {
  String t(String key) => _i10n.t(lang, key);
  final ctx = FlatScoreContext(score: score);

  final respRate = ctx.boolValue('qsofa-resp-rate')?['points'] as num?;
  final mentation = ctx.boolValue('qsofa-mentation')?['points'] as num?;
  final sbp = ctx.boolValue('qsofa-sbp')?['points'] as num?;

  if (respRate == null || mentation == null || sbp == null) {
    return ScoreResult.incomplete(
      label: 'qSOFA',
      interpretation: t('calc.incomplete'),
    );
  }

  final total = (respRate + mentation + sbp).toInt();

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'qSOFA',
    primaryResult: '$total / 3',
    primaryInterpretation: _interpret(total, t),
  );
}

String _interpret(int total, String Function(String) t) =>
    total >= 2 ? t('calc.interp.high') : t('calc.interp.low');

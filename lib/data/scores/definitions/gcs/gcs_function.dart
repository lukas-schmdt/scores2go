import 'package:scores_2_go/data/scores/definitions/gcs/gcs_i10n.dart';
import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

// Sentinel value stored in VariableOption.value for "not testable".
const _kNt = -1;

final _i10n = GcsI10n();

ScoreResult gcsFunction(Score score, String lang) {
  String t(String key) => _i10n.t(lang, key);
  final ctx = FlatScoreContext(score: score);

  final eRaw = ctx.singleSelect('gcs-eyes')?['value'] as num?;
  final vRaw = ctx.singleSelect('gcs-verbal')?['value'] as num?;
  final mRaw = ctx.singleSelect('gcs-motor')?['value'] as num?;

  if (eRaw == null && vRaw == null && mRaw == null) {
    return ScoreResult.incomplete(
      label: 'GCS',
      interpretation: t('calc.incomplete'),
    );
  }

  // Treat NT as answered but contributing 0 to the sum.
  final eNt = eRaw == _kNt;
  final vNt = vRaw == _kNt;
  final mNt = mRaw == _kNt;

  final eVal = (eNt || eRaw == null) ? 0 : eRaw.toInt();
  final vVal = (vNt || vRaw == null) ? 0 : vRaw.toInt();
  final mVal = (mNt || mRaw == null) ? 0 : mRaw.toInt();
  final total = eVal + vVal + mVal;

  // EVM notation: NT subscales shown as ENT / VNT / MNT.
  String eLabel() => eRaw == null ? '' : (eNt ? 'ENT' : 'E$eVal');
  String vLabel() => vRaw == null ? '' : (vNt ? 'VNT' : 'V$vVal');
  String mLabel() => mRaw == null ? '' : (mNt ? 'MNT' : 'M$mVal');

  final allAnswered = eRaw != null && vRaw != null && mRaw != null;
  final anyNt = eNt || vNt || mNt;

  if (!allAnswered) {
    // Still waiting for at least one subscale.
    final evm = [
      if (eRaw != null) eLabel(),
      if (vRaw != null) vLabel(),
      if (mRaw != null) mLabel(),
    ].join(' ');
    return ScoreResult(
      state: ScoreState.incomplete,
      primaryLabel: t('calc.partialLabel'),
      primaryResult: '$total',
      primaryInterpretation: t('calc.completeAllThree'),
      secondaryLabel: t('calc.evmLabel'),
      secondaryResult: evm,
    );
  }

  final evm = '${eLabel()} ${vLabel()} ${mLabel()}';

  // Max possible total depends on which subscales are NT.
  final maxE = eNt ? 0 : 4;
  final maxV = vNt ? 0 : 5;
  final maxM = mNt ? 0 : 6;
  final maxTotal = maxE + maxV + maxM;

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'GCS',
    primaryResult: anyNt ? '$total / $maxTotal' : '$total / 15',
    primaryInterpretation: anyNt
        ? '${_interpret(total, t)} ${t('calc.ntExcluded')}'
        : _interpret(total, t),
    secondaryLabel: t('calc.evmLabel'),
    secondaryResult: evm,
  );
}

String _interpret(int gcs, String Function(String) t) {
  if (gcs >= 13) return t('calc.interp.mild');
  if (gcs >= 9) return t('calc.interp.moderate');
  return t('calc.interp.severe');
}

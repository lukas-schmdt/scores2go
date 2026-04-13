import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

ScoreResult horovitzFunction(Score score) {
  final ctx = FlatScoreContext(score: score);

  // PaO2 is stored in mmHg (canonical unit of Units.pressure).
  // FiO2 is stored as % (21–100).
  final pao2 = ctx.numValue('horovitz-pao2')?['value'] as num?;
  final fio2 = ctx.numValue('horovitz-fio2')?['value'] as num?;

  if (pao2 == null && fio2 == null) {
    return ScoreResult.incomplete(
      label: 'Horovitz Quotient',
      interpretation: 'Enter PaO₂ and FiO₂ to calculate the ratio.',
    );
  }

  if (pao2 == null || fio2 == null) {
    return ScoreResult.incomplete(
      label: 'Horovitz Quotient',
      interpretation: pao2 == null ? 'PaO₂ is missing.' : 'FiO₂ is missing.',
    );
  }

  if (fio2 <= 0) {
    return ScoreResult(
      state: ScoreState.error,
      primaryLabel: 'Horovitz Quotient',
      primaryResult: '—',
      primaryInterpretation: 'FiO₂ must be greater than 0 %.',
    );
  }

  // FiO2 stored as %, convert to fraction for the ratio.
  final ratio = pao2.toDouble() / (fio2.toDouble() / 100.0);
  final ratioRounded = ratio.round();

  return ScoreResult(
    state: ScoreState.success,
    primaryLabel: 'Horovitz Quotient',
    primaryResult: '$ratioRounded mmHg',
    primaryInterpretation: _interpret(ratio),
    secondaryLabel: 'Inputs',
    secondaryResult: 'PaO₂ ${pao2.toStringAsFixed(0)} mmHg · FiO₂ ${fio2.toStringAsFixed(0)} %',
  );
}

String _interpret(double ratio) {
  if (ratio >= 400) return 'Normal oxygenation (≥ 400)';
  if (ratio >= 300) return 'Mild hypoxemia (300–399)';
  if (ratio >= 200) return 'Mild ARDS — Berlin Definition (200–299)';
  if (ratio >= 100) return 'Moderate ARDS — Berlin Definition (100–199)';
  return 'Severe ARDS — Berlin Definition (< 100)';
}

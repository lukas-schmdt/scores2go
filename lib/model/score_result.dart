enum ScoreState { initial, incomplete, success, error }

class ScoreResult {
  final ScoreState state;
  final String? primaryLabel;
  final String? primaryResult;
  final String? primaryInterpretation;
  final String? secondaryLabel;
  final String? secondaryResult;
  final String? secondaryInterpretation;

  ScoreResult({
    required this.state,
    this.primaryLabel,
    this.primaryResult,
    this.primaryInterpretation,
    this.secondaryLabel,
    this.secondaryResult,
    this.secondaryInterpretation,
  });

  ScoreResult.incomplete({
    String? label = 'Incomplete score data',
    String? interpretation =
        'Please provide all required values for the score.',
  }) : this(
         state: ScoreState.incomplete,
         primaryLabel: label,
         primaryResult: '',
         primaryInterpretation: interpretation,
       );
}

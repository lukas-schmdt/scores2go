part of 'score_entry_bloc.dart';

enum Status { initial, loading, success, error }

class ScoreEntryState extends Equatable {
  final Status status;
  final Score score;
  final ScoreResult? scoreResult;
  final bool isCalculating;

  const ScoreEntryState({
    required this.status,
    required this.score,
    this.scoreResult,
    this.isCalculating = false,
  });

  @override
  List<Object?> get props => [status, score, scoreResult, isCalculating];

  ScoreEntryState copyWith({
    Status? status,
    Score? score,
    ScoreResult? scoreResult,
    bool? isCalculating,
  }) {
    return ScoreEntryState(
      status: status ?? this.status,
      score: score ?? this.score,
      scoreResult: scoreResult ?? this.scoreResult,
      isCalculating: isCalculating ?? this.isCalculating,
    );
  }
}

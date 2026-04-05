part of 'scores_bloc.dart';

enum ScoresStatus { initial, loading, success, failure }

class ScoresState extends Equatable {
  final ScoresStatus status;
  final List<Score> scores;
  final bool showSearch;
  final String searchString;
  const ScoresState({
    required this.status,
    required this.scores,
    required this.showSearch,
    required this.searchString,
  });

  ScoresState copyWith({
    ScoresStatus? status,
    List<Score>? scores,
    bool? showSearch,
    String? searchString,
  }) {
    return ScoresState(
      status: status ?? this.status,
      scores: scores ?? this.scores,
      showSearch: showSearch ?? this.showSearch,
      searchString: searchString ?? this.searchString,
    );
  }

  @override
  List<Object> get props => [status, scores, showSearch, searchString];

  const ScoresState.initial()
    : status = ScoresStatus.initial,
      scores = const [],
      showSearch = false,
      searchString = '';
}

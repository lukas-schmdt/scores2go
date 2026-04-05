import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scores_2_go_2/model/score.dart';
import 'package:scores_2_go_2/repo/scores_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'scores_event.dart';
part 'scores_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class ScoresBloc extends Bloc<ScoresEvent, ScoresState> {
  final ScoresRepository repo;

  ScoresBloc(this.repo) : super(ScoresState.initial()) {
    on<LoadScoresEvent>(_onLoadScores);
    on<ToggleShowSearchEvent>(_onToggleShowSearch);
    on<SearchScoresEvent>(
      _onSearchScores,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  Future<void> _onLoadScores(
    LoadScoresEvent event,
    Emitter<ScoresState> emit,
  ) async {
    emit(state.copyWith(status: ScoresStatus.loading));
    final results = await Future.wait([repo.getScores(event.force)]);

    final List<Score> scores = results[0];

    emit(state.copyWith(status: ScoresStatus.success, scores: scores));
  }

  void _onToggleShowSearch(
    ToggleShowSearchEvent event,
    Emitter<ScoresState> emit,
  ) {
    emit(state.copyWith(showSearch: !state.showSearch, scores: state.scores));
  }

  Future<void> _onSearchScores(
    SearchScoresEvent event,
    Emitter<ScoresState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ScoresStatus.loading,
        searchString: event.searchString,
      ),
    );

    await Future.delayed(Duration(seconds: 1));

    final searchString = event.searchString.toLowerCase();

    var filteredScores = await repo.getScoresBySearchString(searchString);

    emit(state.copyWith(status: ScoresStatus.success, scores: filteredScores));
  }
}

part of 'scores_bloc.dart';

sealed class ScoresEvent extends Equatable {
  const ScoresEvent();

  @override
  List<Object> get props => [];
}

class LoadScoresEvent extends ScoresEvent {
  final bool force;
  const LoadScoresEvent({this.force = false});
}

class ToggleShowSearchEvent extends ScoresEvent {}

class SearchScoresEvent extends ScoresEvent {
  final String searchString;

  const SearchScoresEvent({required this.searchString});
}

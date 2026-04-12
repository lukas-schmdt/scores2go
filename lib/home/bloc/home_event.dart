part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class SetScreenEvent extends HomeEvent {
  final int screenId;
  SetScreenEvent({required this.screenId});
}

class SelectScoreEvent extends HomeEvent {
  final Score score;
  const SelectScoreEvent(this.score);

  @override
  List<Object> get props => [score];
}

class ClearSelectedScoreEvent extends HomeEvent {}

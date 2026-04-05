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

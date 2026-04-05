part of 'recently_used_bloc.dart';

sealed class RecentlyUsedEvent extends Equatable {
  const RecentlyUsedEvent();

  @override
  List<Object> get props => [];
}

class LoadRecentlyUsedEvent extends RecentlyUsedEvent {}

class JustUsedEvent extends RecentlyUsedEvent {
  final int scoreId;
  const JustUsedEvent(this.scoreId);
}

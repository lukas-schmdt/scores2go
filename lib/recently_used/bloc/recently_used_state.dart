part of 'recently_used_bloc.dart';

enum RecentlyUsedStatus { initial, loading, success, failure }

class RecentlyUsedState extends Equatable {
  final RecentlyUsedStatus status;
  final List<Score> recentlyUsedScores;

  const RecentlyUsedState({
    required this.status,
    required this.recentlyUsedScores,
  });

  RecentlyUsedState copyWith({
    RecentlyUsedStatus? status,
    List<Score>? recentlyUsedScores,
  }) {
    return RecentlyUsedState(
      status: status ?? this.status,
      recentlyUsedScores: recentlyUsedScores ?? this.recentlyUsedScores,
    );
  }

  @override
  List<Object> get props => [status, recentlyUsedScores];
}

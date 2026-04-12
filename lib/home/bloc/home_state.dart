part of 'home_bloc.dart';

enum homeStatus { initial, loading, success, failed }

class HomeState extends Equatable {
  const HomeState({
    required this.status,
    required this.screenId,
    this.selectedScore,
  });

  final homeStatus status;
  final int screenId;
  final Score? selectedScore;

  @override
  List<Object?> get props => [status, screenId, selectedScore];

  HomeState copyWith({
    homeStatus? status,
    int? screenId,
    Score? selectedScore,
    bool clearSelectedScore = false,
  }) {
    return HomeState(
      status: status ?? this.status,
      screenId: screenId ?? this.screenId,
      selectedScore:
          clearSelectedScore ? null : (selectedScore ?? this.selectedScore),
    );
  }
}

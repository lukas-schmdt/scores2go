part of 'home_bloc.dart';

enum homeStatus { initial, loading, success, failed }

class HomeState extends Equatable {
  const HomeState({required this.status, required this.screenId});

  final homeStatus status;
  final int screenId;

  @override
  List<Object> get props => [status, screenId];

  HomeState copyWith({homeStatus? status, int? screenId}) {
    return HomeState(
      status: status ?? this.status,
      screenId: screenId ?? this.screenId,
    );
  }
}

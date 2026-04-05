part of 'user_favorites_bloc.dart';

enum UserFavoritesStatus { initial, loading, loaded, error }

class UserFavoritesState extends Equatable {
  const UserFavoritesState({
    this.status = UserFavoritesStatus.initial,
    this.favorites = const [],
    this.scores = const [],
    this.errorMessage,
  });

  final UserFavoritesStatus status;
  final List<int> favorites;
  final List<Score> scores;
  final String? errorMessage;

  UserFavoritesState copyWith({
    UserFavoritesStatus? status,
    List<int>? favorites,
    List<Score>? scores,
    String? errorMessage,
  }) {
    return UserFavoritesState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      scores: scores ?? this.scores,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, favorites, scores, errorMessage];
}

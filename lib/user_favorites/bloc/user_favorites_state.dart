part of 'user_favorites_bloc.dart';

enum UserFavoritesStatus { initial, loading, loaded, error }

class UserFavoritesState extends Equatable {
  const UserFavoritesState({
    this.status = UserFavoritesStatus.initial,
    this.favorites = const [],
    this.scores = const [],
    this.errorMessage,
    this.pendingId,
  });

  final UserFavoritesStatus status;
  final List<int> favorites;
  final List<Score> scores;
  final String? errorMessage;
  /// Score id currently being added/removed (shows spinner in button).
  final int? pendingId;

  UserFavoritesState copyWith({
    UserFavoritesStatus? status,
    List<int>? favorites,
    List<Score>? scores,
    String? errorMessage,
    int? pendingId,
    bool clearPending = false,
  }) {
    return UserFavoritesState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      scores: scores ?? this.scores,
      errorMessage: errorMessage ?? this.errorMessage,
      pendingId: clearPending ? null : (pendingId ?? this.pendingId),
    );
  }

  @override
  List<Object?> get props => [status, favorites, scores, errorMessage, pendingId];
}

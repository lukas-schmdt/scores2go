part of 'user_favorites_bloc.dart';

sealed class UserFavoritesEvent extends Equatable {
  const UserFavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadUserFavoritesEvent extends UserFavoritesEvent {
  const LoadUserFavoritesEvent();
}

class AddUserFavoriteEvent extends UserFavoritesEvent {
  final int scoreId;

  const AddUserFavoriteEvent(this.scoreId);

  @override
  List<Object> get props => [scoreId];
}

class RemoveUserFavoriteEvent extends UserFavoritesEvent {
  final int scoreId;

  const RemoveUserFavoriteEvent(this.scoreId);

  @override
  List<Object> get props => [scoreId];
}

class ReorderFavoriteEvent extends UserFavoritesEvent {
  final int oldIndex;
  final int newIndex;

  const ReorderFavoriteEvent(this.oldIndex, this.newIndex);

  @override
  List<Object> get props => [oldIndex, newIndex];
}

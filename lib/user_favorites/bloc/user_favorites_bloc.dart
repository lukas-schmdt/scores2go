import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scores_2_go_2/model/score.dart';
import 'package:scores_2_go_2/repo/scores_repository.dart';

part 'user_favorites_event.dart';
part 'user_favorites_state.dart';

class UserFavoritesBloc extends Bloc<UserFavoritesEvent, UserFavoritesState> {
  final ScoresRepository repo;

  UserFavoritesBloc(this.repo) : super(const UserFavoritesState()) {
    on<LoadUserFavoritesEvent>(_onLoad);
    on<AddUserFavoriteEvent>(_onAdd);
    on<RemoveUserFavoriteEvent>(_onRemove);
    on<ReorderFavoriteEvent>(_onReorder);
  }

  Future<void> _onLoad(
    LoadUserFavoritesEvent event,
    Emitter<UserFavoritesState> emit,
  ) async {
    emit(state.copyWith(status: UserFavoritesStatus.loading));
    try {
      final favoriteIds = await repo.getFavoriteScoreIds();
      final allScores = await repo.getScores();
      final favoriteScores =
          allScores.where((s) => favoriteIds.contains(s.id)).toList();

      emit(state.copyWith(
        status: UserFavoritesStatus.loaded,
        favorites: favoriteIds,
        scores: favoriteScores,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: UserFavoritesStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onAdd(
    AddUserFavoriteEvent event,
    Emitter<UserFavoritesState> emit,
  ) async {
    if (state.favorites.contains(event.scoreId)) return;
    try {
      await repo.addFavoriteScoreId(event.scoreId, state.favorites.length);

      final allScores = await repo.getScores();
      final updatedIds = [...state.favorites, event.scoreId];
      final updatedScores =
          allScores.where((s) => updatedIds.contains(s.id)).toList();

      emit(state.copyWith(
        status: UserFavoritesStatus.loaded,
        favorites: updatedIds,
        scores: updatedScores,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: UserFavoritesStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRemove(
    RemoveUserFavoriteEvent event,
    Emitter<UserFavoritesState> emit,
  ) async {
    try {
      await repo.removeFavoriteScoreId(event.scoreId);

      final updatedIds =
          state.favorites.where((id) => id != event.scoreId).toList();
      final updatedScores =
          state.scores.where((s) => updatedIds.contains(s.id)).toList();

      emit(state.copyWith(
        status: UserFavoritesStatus.loaded,
        favorites: updatedIds,
        scores: updatedScores,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: UserFavoritesStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onReorder(
    ReorderFavoriteEvent event,
    Emitter<UserFavoritesState> emit,
  ) async {
    final list = List<int>.from(state.favorites);
    final moved = list.removeAt(event.oldIndex);
    final insertAt =
        event.oldIndex < event.newIndex ? event.newIndex - 1 : event.newIndex;
    list.insert(insertAt, moved);

    final reorderedScores =
        list.map((id) => state.scores.firstWhere((s) => s.id == id)).toList();

    // Optimistic update — UI reflects the new order immediately.
    emit(state.copyWith(favorites: list, scores: reorderedScores));

    try {
      await repo.updateFavoritePositions(list);
    } catch (e) {
      emit(state.copyWith(
        status: UserFavoritesStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}

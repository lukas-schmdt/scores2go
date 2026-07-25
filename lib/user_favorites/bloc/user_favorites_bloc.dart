import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/repo/scores_repository.dart';

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
      final scoresById = {for (final s in allScores) s.id: s};
      // Keep only favorites that still resolve to a known score, preserving the
      // stored order. This keeps `favorites` and `scores` consistent so lookups
      // elsewhere can't fail on a stale/removed score id.
      final resolvedIds =
          favoriteIds.where(scoresById.containsKey).toList();
      final favoriteScores =
          resolvedIds.map((id) => scoresById[id]!).toList();

      emit(
        state.copyWith(
          status: UserFavoritesStatus.loaded,
          favorites: resolvedIds,
          scores: favoriteScores,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: UserFavoritesStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onAdd(
    AddUserFavoriteEvent event,
    Emitter<UserFavoritesState> emit,
  ) async {
    if (state.favorites.contains(event.scoreId)) return;
    emit(state.copyWith(pendingId: event.scoreId));
    try {
      await repo.addFavoriteScoreId(event.scoreId, state.favorites.length);

      final allScores = await repo.getScores();
      final updatedIds = [...state.favorites, event.scoreId];
      final updatedScores = allScores
          .where((s) => updatedIds.contains(s.id))
          .toList();

      emit(
        state.copyWith(
          status: UserFavoritesStatus.loaded,
          favorites: updatedIds,
          scores: updatedScores,
          clearPending: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: UserFavoritesStatus.error,
          errorMessage: e.toString(),
          clearPending: true,
        ),
      );
    }
  }

  Future<void> _onRemove(
    RemoveUserFavoriteEvent event,
    Emitter<UserFavoritesState> emit,
  ) async {
    final updatedIds = state.favorites
        .where((id) => id != event.scoreId)
        .toList();
    final updatedScores = state.scores
        .where((s) => updatedIds.contains(s.id))
        .toList();

    emit(state.copyWith(
      status: UserFavoritesStatus.loaded,
      favorites: updatedIds,
      scores: updatedScores,
    ));

    try {
      await repo.removeFavoriteScoreId(event.scoreId);
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
    final insertAt = event.oldIndex < event.newIndex
        ? event.newIndex - 1
        : event.newIndex;
    list.insert(insertAt, moved);

    final scoresById = {for (final s in state.scores) s.id: s};
    final reorderedScores =
        list.map((id) => scoresById[id]).whereType<Score>().toList();

    emit(state.copyWith(favorites: list, scores: reorderedScores));

    try {
      await repo.updateFavoritePositions(list);
    } catch (e) {
      emit(
        state.copyWith(
          status: UserFavoritesStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

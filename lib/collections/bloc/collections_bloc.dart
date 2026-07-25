import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scores_2_go/model/score_collection.dart';
import 'package:scores_2_go/repo/collections_repository.dart';

part 'collections_event.dart';
part 'collections_state.dart';

class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  CollectionsBloc(this.repo) : super(const CollectionsState()) {
    on<LoadCollectionsEvent>(_onLoad);
    on<CreateCollectionEvent>(_onCreate);
    on<RenameCollectionEvent>(_onRename);
    on<DeleteCollectionEvent>(_onDelete);
    on<AddScoreToCollectionEvent>(_onAddScore);
    on<RemoveScoreFromCollectionEvent>(_onRemoveScore);
  }

  final CollectionsRepository repo;

  Future<void> _onLoad(
    LoadCollectionsEvent event,
    Emitter<CollectionsState> emit,
  ) async {
    emit(state.copyWith(status: CollectionsStatus.loading));
    try {
      final collections = await repo.getCollections();
      emit(state.copyWith(
        status: CollectionsStatus.loaded,
        collections: collections,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CollectionsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onCreate(
    CreateCollectionEvent event,
    Emitter<CollectionsState> emit,
  ) async {
    try {
      await repo.createCollection(event.display);
      // Reload to get real IDs from DB
      final collections = await repo.getCollections();
      emit(state.copyWith(
        status: CollectionsStatus.loaded,
        collections: collections,
      ));
    } catch (e, st) {
      dev.log('_onCreate error', name: 'CollectionsBloc', error: e, stackTrace: st);
      emit(state.copyWith(
        status: CollectionsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRename(
    RenameCollectionEvent event,
    Emitter<CollectionsState> emit,
  ) async {
    try {
      await repo.renameCollection(event.collectionId, event.display);
      final updated = state.collections
          .map((c) => c.id == event.collectionId
              ? c.copyWith(display: event.display)
              : c)
          .toList();
      emit(state.copyWith(collections: updated));
    } catch (e) {
      emit(state.copyWith(
        status: CollectionsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onDelete(
    DeleteCollectionEvent event,
    Emitter<CollectionsState> emit,
  ) async {
    try {
      await repo.deleteCollection(event.collectionId);
      final updated = state.collections
          .where((c) => c.id != event.collectionId)
          .toList();
      emit(state.copyWith(collections: updated));
    } catch (e) {
      emit(state.copyWith(
        status: CollectionsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onAddScore(
    AddScoreToCollectionEvent event,
    Emitter<CollectionsState> emit,
  ) async {
    try {
      await repo.addScore(event.collectionId, event.scoreId);
      final updated = state.collections.map((c) {
        if (c.id != event.collectionId) return c;
        if (c.scoreIds.contains(event.scoreId)) return c;
        return c.copyWith(scoreIds: [...c.scoreIds, event.scoreId]);
      }).toList();
      emit(state.copyWith(collections: updated));
    } catch (e, st) {
      dev.log('_onAddScore error', name: 'CollectionsBloc', error: e, stackTrace: st);
      emit(state.copyWith(
        status: CollectionsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRemoveScore(
    RemoveScoreFromCollectionEvent event,
    Emitter<CollectionsState> emit,
  ) async {
    try {
      await repo.removeScore(event.collectionId, event.scoreId);
      final updated = state.collections.map((c) {
        if (c.id != event.collectionId) return c;
        return c.copyWith(
          scoreIds: c.scoreIds.where((id) => id != event.scoreId).toList(),
        );
      }).toList();
      emit(state.copyWith(collections: updated));
    } catch (e) {
      emit(state.copyWith(
        status: CollectionsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}

part of 'collections_bloc.dart';

sealed class CollectionsEvent extends Equatable {
  const CollectionsEvent();

  @override
  List<Object> get props => [];
}

class LoadCollectionsEvent extends CollectionsEvent {
  const LoadCollectionsEvent();
}

class CreateCollectionEvent extends CollectionsEvent {
  const CreateCollectionEvent(this.display);
  final String display;

  @override
  List<Object> get props => [display];
}

class RenameCollectionEvent extends CollectionsEvent {
  const RenameCollectionEvent(this.collectionId, this.display);
  final int collectionId;
  final String display;

  @override
  List<Object> get props => [collectionId, display];
}

class DeleteCollectionEvent extends CollectionsEvent {
  const DeleteCollectionEvent(this.collectionId);
  final int collectionId;

  @override
  List<Object> get props => [collectionId];
}

class AddScoreToCollectionEvent extends CollectionsEvent {
  const AddScoreToCollectionEvent(this.collectionId, this.scoreId);
  final int collectionId;
  final int scoreId;

  @override
  List<Object> get props => [collectionId, scoreId];
}

class RemoveScoreFromCollectionEvent extends CollectionsEvent {
  const RemoveScoreFromCollectionEvent(this.collectionId, this.scoreId);
  final int collectionId;
  final int scoreId;

  @override
  List<Object> get props => [collectionId, scoreId];
}

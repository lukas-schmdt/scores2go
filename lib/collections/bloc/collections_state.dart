part of 'collections_bloc.dart';

enum CollectionsStatus { initial, loading, loaded, error }

class CollectionsState extends Equatable {
  const CollectionsState({
    this.status = CollectionsStatus.initial,
    this.collections = const [],
    this.errorMessage,
  });

  final CollectionsStatus status;
  final List<ScoreCollection> collections;
  final String? errorMessage;

  CollectionsState copyWith({
    CollectionsStatus? status,
    List<ScoreCollection>? collections,
    String? errorMessage,
  }) {
    return CollectionsState(
      status: status ?? this.status,
      collections: collections ?? this.collections,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, collections, errorMessage];
}

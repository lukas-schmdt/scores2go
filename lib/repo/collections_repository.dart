import 'package:scores_2_go/data_provider/collections_data_provider.dart';
import 'package:scores_2_go/model/score_collection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CollectionsRepository {
  CollectionsRepository(this.dataProvider);

  final CollectionsDataProvider dataProvider;

  String get _userId {
    final id = Supabase.instance.client.auth.currentUser?.id;
    if (id == null) {
      throw StateError('No authenticated user; cannot access collections.');
    }
    return id;
  }

  Future<List<ScoreCollection>> getCollections() =>
      dataProvider.fetchCollections(_userId);

  Future<void> createCollection(String display) =>
      dataProvider.insertCollection(_userId, display);

  Future<void> renameCollection(int id, String display) =>
      dataProvider.updateCollectionDisplay(_userId, id, display);

  Future<void> deleteCollection(int id) =>
      dataProvider.deleteCollection(_userId, id);

  Future<void> addScore(int collectionId, int scoreId) =>
      dataProvider.insertScoreToCollection(_userId, collectionId, scoreId);

  Future<void> removeScore(int collectionId, int scoreId) =>
      dataProvider.removeScoreFromCollection(_userId, collectionId, scoreId);
}

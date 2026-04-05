import 'package:scores_2_go/data/recently_used.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/data_provider/scores_data_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScoresRepository {
  final ScoresDataProvider dataProvider;

  List<Score> _scoresCache = [];

  ScoresRepository(this.dataProvider);

  String get _userId => Supabase.instance.client.auth.currentUser!.id;

  // ─── Scores ───────────────────────────────────────────────────────────────

  Future<List<Score>> getScores([bool force = false]) async {
    if (_scoresCache.isEmpty || force) {
      final result = await dataProvider.fetchScores();
      _scoresCache = result.map((e) => Score.fromJson(e)).toList();
    }
    return _scoresCache;
  }

  Future<List<Score>> getScoresBySearchString(String searchString) async {
    final allScores = await getScores();
    return allScores
        .where(
          (score) =>
              score.name.toLowerCase().contains(searchString.toLowerCase()) ||
              score.display.toLowerCase().contains(
                searchString.toLowerCase(),
              ) ||
              score.description.toLowerCase().contains(
                searchString.toLowerCase(),
              ),
        )
        .toList();
  }

  // ─── User Favorites ───────────────────────────────────────────────────────

  Future<List<int>> getFavoriteScoreIds() async {
    return dataProvider.fetchFavoriteScoreIds(_userId);
  }

  Future<void> addFavoriteScoreId(int scoreId, int position) async {
    await dataProvider.insertFavoriteScoreId(_userId, scoreId, position);
  }

  Future<void> removeFavoriteScoreId(int scoreId) async {
    await dataProvider.deleteFavoriteScoreId(_userId, scoreId);
  }

  Future<void> updateFavoritePositions(List<int> orderedScoreIds) async {
    await dataProvider.updateFavoritePositions(_userId, orderedScoreIds);
  }

  // ─── Recently Used ────────────────────────────────────────────────────────

  Future<List<int>> getRecentlyUsedScoreIds() async {
    return recentlyUsedScoresDb;
  }

  Future<void> addRecentlyUsedScoreId(List<int> newList) async {
    recentlyUsedScoresDb = newList;
  }
}

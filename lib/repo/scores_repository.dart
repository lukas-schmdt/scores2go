import 'package:scores_2_go/data/scores.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/data_provider/scores_data_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScoresRepository {
  final ScoresDataProvider dataProvider;
  String _locale = 'de';

  ScoresRepository(this.dataProvider);

  String get _userId => Supabase.instance.client.auth.currentUser!.id;

  void setLocale(String locale) {
    _locale = locale;
  }

  // ─── Scores ───────────────────────────────────────────────────────────────

  List<Score> get scores => buildScoresList(_locale);

  Future<List<Score>> getScores([bool force = false]) async {
    return scores;
  }

  Future<List<Score>> getScoresBySearchString(String searchString) async {
    return scores
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

  Future<List<String>> getRecentlyUsedScoreNames() async {
    return [];
  }

  Future<void> addRecentlyUsedScoreName(List<String> newList) async {
    return;
  }
}

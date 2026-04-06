import 'dart:developer' as dev;

import 'package:supabase_flutter/supabase_flutter.dart';

class ScoresDataProvider {
  static const _tag = 'ScoresDataProvider';

  SupabaseClient get _db => Supabase.instance.client;

  // ─── User Favorites ───────────────────────────────────────────────────────

  Future<List<int>> fetchFavoriteScoreIds(String userId) async {
    dev.log('fetchFavoriteScoreIds(userId=$userId)', name: _tag);
    final rows = await _db
        .from('user_favorites')
        .select('score_id')
        .eq('user_id', userId)
        .order('position');
    final ids =
        (rows as List).map<int>((r) => (r['score_id'] as num).toInt()).toList();
    dev.log('fetchFavoriteScoreIds() → $ids', name: _tag);
    return ids;
  }

  Future<void> insertFavoriteScoreId(
    String userId,
    int scoreId,
    int position,
  ) async {
    dev.log(
      'insertFavoriteScoreId(userId=$userId, scoreId=$scoreId, position=$position)',
      name: _tag,
    );
    await _db.from('user_favorites').insert({
      'user_id': userId,
      'score_id': scoreId,
      'position': position,
    });
    dev.log('insertFavoriteScoreId() → ok', name: _tag);
  }

  Future<void> deleteFavoriteScoreId(String userId, int scoreId) async {
    dev.log(
      'deleteFavoriteScoreId(userId=$userId, scoreId=$scoreId)',
      name: _tag,
    );
    await _db
        .from('user_favorites')
        .delete()
        .eq('user_id', userId)
        .eq('score_id', scoreId);
    dev.log('deleteFavoriteScoreId() → ok', name: _tag);
  }

  Future<void> updateFavoritePositions(
    String userId,
    List<int> orderedScoreIds,
  ) async {
    dev.log(
      'updateFavoritePositions(userId=$userId, order=$orderedScoreIds)',
      name: _tag,
    );
    final rows = orderedScoreIds
        .asMap()
        .entries
        .map((e) => {
              'user_id': userId,
              'score_id': e.value,
              'position': e.key,
            })
        .toList();
    await _db
        .from('user_favorites')
        .upsert(rows, onConflict: 'user_id,score_id');
    dev.log('updateFavoritePositions() → ok', name: _tag);
  }
}

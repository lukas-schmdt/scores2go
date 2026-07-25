import 'dart:developer' as dev;

import 'package:scores_2_go/model/score_collection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CollectionsDataProvider {
  static const _tag = 'CollectionsDataProvider';

  SupabaseClient get _db => Supabase.instance.client;

  Future<List<ScoreCollection>> fetchCollections(String userId) async {
    dev.log('fetchCollections(userId=$userId)', name: _tag);
    final rows = await _db
        .from('user_score_collections')
        .select('id, display, score_collection_scores(score_id)')
        .eq('user_id', userId)
        .order('display');

    final result = (rows as List).map((r) {
      final scoreRows = (r['score_collection_scores'] as List?) ?? [];
      final scoreIds =
          scoreRows.map<int>((s) => (s['score_id'] as num).toInt()).toList();
      return ScoreCollection(
        id: (r['id'] as num).toInt(),
        display: r['display'] as String,
        scoreIds: scoreIds,
      );
    }).toList();
    dev.log('fetchCollections() → ${result.length} collections', name: _tag);
    return result;
  }

  Future<void> insertCollection(String userId, String display) async {
    dev.log('insertCollection(userId=$userId, display=$display)', name: _tag);
    await _db.from('user_score_collections').insert({
      'user_id': userId,
      'display': display,
    });
    dev.log('insertCollection() → ok', name: _tag);
  }

  Future<void> updateCollectionDisplay(
    String userId,
    int id,
    String display,
  ) async {
    dev.log('updateCollectionDisplay(id=$id, display=$display)', name: _tag);
    await _db
        .from('user_score_collections')
        .update({'display': display})
        .eq('id', id)
        .eq('user_id', userId);
    dev.log('updateCollectionDisplay() → ok', name: _tag);
  }

  Future<void> deleteCollection(String userId, int id) async {
    dev.log('deleteCollection(id=$id)', name: _tag);
    await _db
        .from('user_score_collections')
        .delete()
        .eq('id', id)
        .eq('user_id', userId);
    dev.log('deleteCollection() → ok', name: _tag);
  }

  Future<void> insertScoreToCollection(String userId, int collectionId, int scoreId) async {
    dev.log(
      'insertScoreToCollection(userId=$userId, collectionId=$collectionId, scoreId=$scoreId)',
      name: _tag,
    );
    try {
      await _db.from('score_collection_scores').insert({
        'user_score_collection_id': collectionId,
        'score_id': scoreId,
        'user_id': userId,
      });
      dev.log('insertScoreToCollection() → ok', name: _tag);
    } catch (e, st) {
      dev.log('insertScoreToCollection() → ERROR: $e', name: _tag, error: e, stackTrace: st);
      rethrow;
    }
  }

  Future<void> removeScoreFromCollection(
    String userId,
    int collectionId,
    int scoreId,
  ) async {
    dev.log(
      'removeScoreFromCollection(collectionId=$collectionId, scoreId=$scoreId)',
      name: _tag,
    );
    await _db
        .from('score_collection_scores')
        .delete()
        .eq('user_score_collection_id', collectionId)
        .eq('score_id', scoreId)
        .eq('user_id', userId);
    dev.log('removeScoreFromCollection() → ok', name: _tag);
  }
}

import 'dart:developer' as dev;

import 'package:supabase_flutter/supabase_flutter.dart';

class ScoreOpensDataProvider {
  static const _tag = 'ScoreOpensDataProvider';

  SupabaseClient get _db => Supabase.instance.client;

  Future<void> insertScoreOpen(
    int scoreId,
    String platform,
    String locale,
  ) async {
    dev.log(
      'insertScoreOpen(scoreId=$scoreId, platform=$platform, locale=$locale)',
      name: _tag,
    );
    await _db.from('score_opens').insert({
      'score_id': scoreId,
      'platform': platform,
      'locale': locale,
    });
    dev.log('insertScoreOpen() → ok', name: _tag);
  }
}

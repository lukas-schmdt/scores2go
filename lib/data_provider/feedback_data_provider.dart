import 'dart:developer' as dev;

import 'package:supabase_flutter/supabase_flutter.dart';

class FeedbackDataProvider {
  static const _tag = 'FeedbackDataProvider';

  SupabaseClient get _db => Supabase.instance.client;

  Future<void> insertFeedback(
    String userId,
    String feedback,
    int stars,
  ) async {
    dev.log(
      'insertFeedback(userId=$userId, stars=$stars)',
      name: _tag,
    );
    await _db.from('user_feedback').insert({
      'user_id': userId,
      'feedback': feedback,
      'stars': stars,
    });
    dev.log('insertFeedback() → ok', name: _tag);
  }
}

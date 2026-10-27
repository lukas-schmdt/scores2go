import 'dart:developer' as dev;

import 'package:supabase_flutter/supabase_flutter.dart';

class FeedbackDataProvider {
  static const _tag = 'FeedbackDataProvider';

  SupabaseClient get _db => Supabase.instance.client;

  Future<void> insertFeedback(
    String? feedback,
    int? stars,
  ) async {
    dev.log(
      'insertFeedback(stars=$stars)',
      name: _tag,
    );
    await _db.from('user_feedback').insert({
      'feedback': feedback,
      'stars': stars,
    });
    dev.log('insertFeedback() → ok', name: _tag);
  }
}

import 'package:scores_2_go/data_provider/feedback_data_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FeedbackRepository {
  FeedbackRepository(this.dataProvider);

  final FeedbackDataProvider dataProvider;

  String get _userId {
    final id = Supabase.instance.client.auth.currentUser?.id;
    if (id == null) {
      throw StateError('No authenticated user; cannot submit feedback.');
    }
    return id;
  }

  Future<void> submitFeedback(String feedback, int stars) =>
      dataProvider.insertFeedback(_userId, feedback, stars);
}

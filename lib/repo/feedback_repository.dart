import 'package:scores_2_go/data_provider/feedback_data_provider.dart';

class FeedbackRepository {
  FeedbackRepository(this.dataProvider);

  final FeedbackDataProvider dataProvider;

  /// Works signed in or anonymous: `user_id` is filled by the column default
  /// `auth.uid()`, which is null for anonymous requests.
  Future<void> submitFeedback(String feedback, int stars) =>
      dataProvider.insertFeedback(feedback, stars);
}

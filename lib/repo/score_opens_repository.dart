import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:scores_2_go/data_provider/score_opens_data_provider.dart';
import 'package:scores_2_go/model/score.dart';

class ScoreOpensRepository {
  ScoreOpensRepository(this.dataProvider);

  final ScoreOpensDataProvider dataProvider;

  /// Anonymous usage count — no user id is sent. Fire-and-forget: a failed or
  /// offline insert must never affect opening the score.
  void logOpen(Score score, String locale) {
    final platform = kIsWeb ? 'web' : defaultTargetPlatform.name;
    unawaited(
      dataProvider
          .insertScoreOpen(score.id, platform, locale)
          .catchError((Object e) {
        dev.log('logOpen() failed: $e', name: 'ScoreOpensRepository');
      }),
    );
  }
}

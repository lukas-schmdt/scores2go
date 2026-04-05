import 'package:scores_2_go_2/function/score_items_to_map.dart';
import 'package:scores_2_go_2/model/score.dart';
import 'package:scores_2_go_2/model/score_visibility.dart';

/// Maps a score ID to a function that computes which variables are active for
/// the current state of that score.
///
/// Add an entry here whenever a score has conditional / non-linear fields.
/// Scores without an entry default to [ScoreVisibility.all()] (all active).
final Map<int, ScoreVisibility Function(Score)> scoreVisibilityMapper = {
  1: _demoVisibility,
  3: _apache2Visibility,
};

// ─── APACHE II ────────────────────────────────────────────────────────────────
//
// A-aDO2 (id 6) only shown when FiO2 ≥ 50% (id 5 = true).
// PaO2   (id 7) only shown when FiO2 <  50% (id 5 = false or unanswered).
ScoreVisibility _apache2Visibility(Score score) {
  final ctx = FlatScoreContext(score: score);
  final highFio2 = (ctx.boolValue(5)?['value'] as bool?) ?? false;

  return ScoreVisibility(
    activeVariableIds: {
      1, 2, 3, 4, 5,        // always active
      if (highFio2) 6 else 7, // oxygenation – conditional on FiO2
      8, 9, 10, 11, 12, 13, 14, 15, // always active
      16,                   // age – always active
      17,                   // chronic health – always active
    },
  );
}

// ─── Demo Score ───────────────────────────────────────────────────────────────
//
// FiO₂ (id 5) only shown when mechanically ventilated (id 4 = true).
ScoreVisibility _demoVisibility(Score score) {
  final ctx = FlatScoreContext(score: score);
  final vented = ctx.boolValue(4);
  final isVented = (vented?['value'] as bool?) ?? false;

  return ScoreVisibility(
    activeVariableIds: {
      1, // O₂ therapy     – always active
      2, // Heart rate     – always active
      3, // Alertness      – always active
      4, // Ventilated     – always active
      if (isVented) 5, // FiO₂ – only when ventilated
      6, // Comorbidities  – always active
      7, // Blood sugar    – always active
    },
  );
}

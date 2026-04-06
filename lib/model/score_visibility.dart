/// Describes which variables are currently active (visible) within a score.
///
/// Variables absent from [activeVariableNames] will be hidden in the UI and
/// excluded from completion counting. Groups whose every item is inactive are
/// hidden automatically.
///
/// When [activeVariableNames] is `null` every variable is considered active
/// (default when no visibility function is registered for a score).
class ScoreVisibility {
  final Set<String>? activeVariableNames;

  const ScoreVisibility({this.activeVariableNames});

  /// All variables active – used when no visibility function is registered.
  const ScoreVisibility.all() : activeVariableNames = null;

  bool isVariableActive(String name) =>
      activeVariableNames?.contains(name) ?? true;
}

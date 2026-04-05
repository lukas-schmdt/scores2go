/// Describes which variables are currently active (visible) within a score.
///
/// Variables absent from [activeVariableIds] will be hidden in the UI and
/// excluded from completion counting. Groups whose every item is inactive are
/// hidden automatically.
///
/// When [activeVariableIds] is `null` every variable is considered active
/// (default when no visibility function is registered for a score).
class ScoreVisibility {
  final Set<int>? activeVariableIds;

  const ScoreVisibility({this.activeVariableIds});

  /// All variables active – used when no visibility function is registered.
  const ScoreVisibility.all() : activeVariableIds = null;

  bool isVariableActive(int id) => activeVariableIds?.contains(id) ?? true;
}

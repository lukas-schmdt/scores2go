import 'package:scores_2_go/model/model.dart';

/// Returns a copy of [score] with the named variables set to the given values,
/// so a pure `scoreFunction` can be exercised without building UI.
///
/// Value types per variable kind:
/// * [VariableBool]      → `bool` (or `null` to leave unanswered)
/// * [VariableNumber]    → `num`  (or `null`)
/// * [VariableSelection] → the `num` `value` of the option to select
///
/// Variables not present in [values] are left untouched (unanswered).
Score withValues(Score score, Map<String, Object?> values) {
  final groups = score.groups.map((group) {
    final items = group.items.map<Variable>((v) {
      if (!values.containsKey(v.name)) return v;
      final value = values[v.name];

      if (v is VariableBool) {
        return v.copyWith(value: value as bool?);
      }
      if (v is VariableNumber) {
        return v.copyWith(value: () => value as num?);
      }
      if (v is VariableSelection) {
        final options = v.options
            .map((o) => o.copyWith(isSelected: o.value == value))
            .toList();
        return v.copyWith(options: options);
      }
      return v;
    }).toList();
    return group.copyWith(items: items);
  }).toList();

  return score.copyWith(groups: groups);
}

/// Convenience: run the score's own calculation function over [values].
ScoreResult compute(Score score, Map<String, Object?> values) {
  final populated = withValues(score, values);
  return score.scoreFunction!(populated);
}

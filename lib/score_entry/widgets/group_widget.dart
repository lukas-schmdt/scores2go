import 'package:flutter/material.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/model/score_group.dart';
import 'package:scores_2_go/model/score_visibility.dart';
import 'package:scores_2_go/model/variable_bool.dart';
import 'package:scores_2_go/model/variable_number.dart';
import 'package:scores_2_go/model/variable_selection.dart';
import 'package:scores_2_go/score_entry/widgets/bool_widget.dart';
import 'package:scores_2_go/score_entry/widgets/number_widget.dart';
import 'package:scores_2_go/score_entry/widgets/selection_widget.dart';

class GroupWidget extends StatelessWidget {
  const GroupWidget({
    super.key,
    required this.group,
    required this.visibility,
    required this.itemKeys,
    required this.keyFor,
  });

  final Group group;
  final ScoreVisibility visibility;
  final Map<String, GlobalKey> itemKeys;
  final GlobalKey Function(String variableName) keyFor;

  @override
  Widget build(BuildContext context) {
    final activeItems = group.items
        .where((item) => visibility.isVariableActive(item.name))
        .toList();

    if (activeItems.isEmpty) return const SizedBox.shrink();

    final cs = Theme.of(context).colorScheme;
    // Use teal (secondary) for the group accent — contrasts on both navy and light
    final accent = cs.secondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (group.isVisible)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: accent, width: 3)),
              color: accent.withValues(alpha: 0.07),
            ),
            child: Text(
              group.display,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ...activeItems.map((item) {
          if (item is VariableBool) {
            return BooleanVariable(key: keyFor(item.name), item: item);
          } else if (item is VariableNumber) {
            return NumberVariable(key: keyFor(item.name), item: item);
          } else if (item is VariableSelection) {
            return SelectionVariable(key: keyFor(item.name), item: item);
          } else {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Text(AppLocalizations.of(context)!.unsupportedVariableType),
            );
          }
        }),
      ],
    );
  }
}

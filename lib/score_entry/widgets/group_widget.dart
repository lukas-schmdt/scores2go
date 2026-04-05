import 'package:flutter/material.dart';
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
  final Map<int, GlobalKey> itemKeys;
  final GlobalKey Function(int variableId) keyFor;

  @override
  Widget build(BuildContext context) {
    final activeItems = group.items
        .where((item) => visibility.isVariableActive(item.id))
        .toList();

    if (activeItems.isEmpty) return const SizedBox.shrink();

    final cs = Theme.of(context).colorScheme;
    final primary = cs.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: primary, width: 3)),
            color: primary.withValues(alpha: 0.06),
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
            return BooleanVariable(
              key: keyFor(item.id),
              groupId: group.id,
              item: item,
            );
          } else if (item is VariableNumber) {
            return NumberVariable(
              key: keyFor(item.id),
              groupId: group.id,
              item: item,
            );
          } else if (item is VariableSelection) {
            return SelectionVariable(
              key: keyFor(item.id),
              groupId: group.id,
              item: item,
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(8),
              child: Text('Nicht unterstützter Variablentyp'),
            );
          }
        }),
      ],
    );
  }
}

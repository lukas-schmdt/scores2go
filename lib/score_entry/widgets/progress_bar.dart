import 'package:flutter/material.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';
import 'package:scores_2_go/model/variable.dart';
import 'package:scores_2_go/model/variable_bool.dart';
import 'package:scores_2_go/model/variable_number.dart';
import 'package:scores_2_go/model/variable_selection.dart';
import 'package:scores_2_go/theme/app_colors.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.score,
    required this.visibility,
    this.onSegmentTap,
  });

  final Score score;
  final ScoreVisibility visibility;
  final void Function(String variableName)? onSegmentTap;

  bool _isAnswered(Variable item) {
    if (item is VariableBool) return item.value != null;
    if (item is VariableNumber) return item.value != null;
    if (item is VariableSelection) return item.options.any((o) => o.isSelected);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final items = score.groups
        .expand((g) => g.items)
        .where((i) => visibility.isVariableActive(i.name))
        .toList();

    if (items.isEmpty) return const SizedBox.shrink();

    final answered = items.where(_isAnswered).length;
    final total = items.length;
    final cs = Theme.of(context).colorScheme;

    const gradientColors = [AppColors.teal, AppColors.blue];

    Color gradientColorAt(int idx, int total) {
      final t = total <= 1 ? 0.0 : idx / (total - 1);
      final a = gradientColors[0];
      final b = gradientColors[1];
      return Color.lerp(a, b, t)!;
    }

    final List<Widget> segments = [];
    for (int idx = 0; idx < items.length; idx++) {
      final item = items[idx];
      final segmentColor = _isAnswered(item)
          ? gradientColorAt(idx, items.length)
          : cs.outlineVariant;

      segments.add(
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onSegmentTap?.call(item.name),
            child: SizedBox(
              height: 28,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: segmentColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      if (idx < items.length - 1) {
        segments.add(const SizedBox(width: 2));
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(child: Row(children: segments)),
          const SizedBox(width: 8),
          Text(
            '$answered / $total',
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

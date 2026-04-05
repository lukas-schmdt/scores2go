import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/model/variable_bool.dart';
import 'package:scores_2_go/score_entry/bloc/score_entry_bloc.dart';

class BooleanVariable extends StatelessWidget {
  const BooleanVariable({super.key, required this.groupId, required this.item});

  final int groupId;
  final VariableBool item;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  item.display,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          if (item.description!.isNotEmpty) ...[
            const SizedBox(height: 3),
            Text(
              item.description!,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _BoolCard(
                  label: 'Ja',
                  points: item.trueValue!,
                  selected: item.value == true,
                  onTap: () => context.read<ScoreEntryBloc>().add(
                    ScoreEntryUpdateBoolEvent(groupId, item.id, true),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _BoolCard(
                  label: 'Nein',
                  points: item.falseValue!,
                  selected: item.value == false,
                  onTap: () => context.read<ScoreEntryBloc>().add(
                    ScoreEntryUpdateBoolEvent(groupId, item.id, false),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

class _BoolCard extends StatelessWidget {
  const _BoolCard({
    required this.label,
    required this.points,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final num points;
  final bool selected;
  final VoidCallback onTap;

  String get _pointsLabel => points > 0 ? '+$points' : '$points';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final primary = cs.primary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: selected ? primary : cs.outlineVariant,
          width: selected ? 2 : 1,
        ),
        color: selected ? primary.withValues(alpha: 0.07) : cs.surface,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected ? primary : Colors.transparent,
                    border: Border.all(
                      color: selected ? primary : cs.outline,
                      width: 2,
                    ),
                  ),
                  child: selected
                      ? const Icon(Icons.check, size: 13, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: selected
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: selected ? primary : cs.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: selected ? primary : cs.surfaceContainerHighest,
                    border: Border.all(
                      color: selected ? primary : cs.outlineVariant,
                    ),
                  ),
                  child: Text(
                    _pointsLabel,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: selected ? Colors.white : cs.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

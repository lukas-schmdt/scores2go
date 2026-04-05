import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go_2/model/variable.dart';
import 'package:scores_2_go_2/model/variable_selection.dart';
import 'package:scores_2_go_2/score_entry/bloc/score_entry_bloc.dart';

class SelectionVariable extends StatelessWidget {
  const SelectionVariable({
    super.key,
    required this.groupId,
    required this.item,
  });

  final int groupId;
  final VariableSelection item;

  @override
  Widget build(BuildContext context) {
    if (item.type != VariableType.select &&
        item.type != VariableType.multiselect) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Text('Nicht unterstützter Variablentyp: ${item.type}'),
      );
    }

    final isMulti = item.type == VariableType.multiselect;
    final cs = Theme.of(context).colorScheme;
    final hasMultipleUnits = (item.units?.length ?? 0) > 1;

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
              if (hasMultipleUnits) _SelectionUnitPicker(item: item),
            ],
          ),
          if (item.description != null && item.description!.isNotEmpty) ...[
            const SizedBox(height: 3),
            Text(
              item.description!,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            ),
          ],
          const SizedBox(height: 10),
          ...item.options.map(
            (opt) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: _OptionCard(
                option: opt,
                activeUnitIndex: item.activeUnitIndex,
                isMulti: isMulti,
                onTap: () => context.read<ScoreEntryBloc>().add(
                  ScoreEntryUpdateSelectionEvent(groupId, item.id, opt),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

class _SelectionUnitPicker extends StatelessWidget {
  const _SelectionUnitPicker({required this.item});
  final VariableSelection item;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final units = item.units!;
    final nextIndex = (item.activeUnitIndex + 1) % units.length;

    return GestureDetector(
      onTap: () => context.read<ScoreEntryBloc>().add(
        ScoreEntryUpdateSelectionUnitEvent(item.id, nextIndex),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
          color: cs.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: cs.primary.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.swap_horiz, size: 16, color: cs.onPrimaryContainer),
            const SizedBox(width: 3),
            Text(
              item.activeUnit?.label ?? '',
              style: TextStyle(
                fontSize: 12,
                color: cs.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.option,
    required this.activeUnitIndex,
    required this.isMulti,
    required this.onTap,
  });

  final VariableOption option;
  final int activeUnitIndex;
  final bool isMulti;
  final VoidCallback onTap;

  String get _pointsLabel {
    if (option.value > 0) return '+${option.value}';
    return option.value.toString();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final primary = cs.primary;
    final selected = option.isSelected;

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
                    shape: isMulti ? BoxShape.rectangle : BoxShape.circle,
                    borderRadius: isMulti ? BorderRadius.circular(4) : null,
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
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.displays != null &&
                                activeUnitIndex < option.displays!.length
                            ? option.displays![activeUnitIndex]
                            : option.display,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: selected
                              ? FontWeight.w600
                              : FontWeight.normal,
                          color: selected ? primary : cs.onSurface,
                        ),
                      ),
                      if (option.description != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          option.description!,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: cs.onSurfaceVariant),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/model/variable_number.dart';
import 'package:scores_2_go/score_entry/bloc/score_entry_bloc.dart';

class NumberVariable extends StatefulWidget {
  const NumberVariable({super.key, required this.item});

  final VariableNumber item;

  @override
  State<NumberVariable> createState() => _NumberVariableState();
}

class _NumberVariableState extends State<NumberVariable> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: _displayText(widget.item));
  }

  @override
  void didUpdateWidget(NumberVariable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.activeUnitIndex != widget.item.activeUnitIndex) {
      final newText = _displayText(widget.item);
      if (_ctrl.text != newText) _ctrl.text = newText;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  String _displayText(VariableNumber item) {
    if (item.value == null) return '';
    final unit = item.activeUnit;
    final v = unit != null ? unit.toDisplay(item.value!) : item.value!;
    return _fmt(v);
  }

  String _fmt(num v) {
    if (v == v.round()) return v.round().toString();
    return v
        .toStringAsFixed(2)
        .replaceAll(RegExp(r'0+$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  }

  String _hintText(BuildContext context, VariableNumber item) {
    final min = item.normMin;
    final max = item.normMax;
    if (min == null || max == null) {
      return AppLocalizations.of(context)!.valueLabel;
    }
    final unit = item.activeUnit;
    if (unit == null) return '$min – $max';
    return '${_fmt(unit.toDisplay(min))} – ${_fmt(unit.toDisplay(max))}';
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final activeUnit = item.activeUnit;
    final hasMultipleUnits = (item.units?.length ?? 0) > 1;
    final cs = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;

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
              if (hasMultipleUnits)
                _UnitChip(item: item)
              else if (activeUnit != null)
                _StaticUnitChip(label: activeUnit.label),
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
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              controller: _ctrl,
              onChanged: (value) {
                final parsed = num.tryParse(value.replaceAll(',', '.'));
                final canonical = parsed != null && activeUnit != null
                    ? activeUnit.toCanonical(parsed)
                    : parsed;
                context.read<ScoreEntryBloc>().add(
                  ScoreEntryUpdateNumberEvent(item.name, canonical),
                );
              },
              validator: (value) {
                if (value == null || value.isEmpty) return null;
                final regex = RegExp(r'^-?\d*([.,])?\d*$');
                if (!regex.hasMatch(value)) return l.invalidNumber;
                if (value.contains('.') && value.contains(',')) {
                  return l.useDotOrCommaNotBoth;
                }
                return null;
              },
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                border: const OutlineInputBorder(),
                hintText: _hintText(context, item),
                hintStyle: TextStyle(color: cs.onSurfaceVariant.withValues(alpha: 0.45)),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _UnitChip extends StatelessWidget {
  const _UnitChip({required this.item});
  final VariableNumber item;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final units = item.units!;
    final nextIndex = (item.activeUnitIndex + 1) % units.length;

    return GestureDetector(
      onTap: () => context.read<ScoreEntryBloc>().add(
        ScoreEntryUpdateUnitEvent(item.name, nextIndex),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: cs.secondaryContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: cs.secondary.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.swap_horiz, size: 15, color: cs.onSecondaryContainer),
            const SizedBox(width: 3),
            Text(
              item.activeUnit?.label ?? '',
              style: TextStyle(
                fontSize: 12,
                color: cs.onSecondaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StaticUnitChip extends StatelessWidget {
  const _StaticUnitChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: cs.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

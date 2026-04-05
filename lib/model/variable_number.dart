import 'package:scores_2_go/model/unit_definition.dart';
import 'package:scores_2_go/model/variable.dart';

class VariableNumber extends Variable {
  /// Always stored in the canonical unit ([units] index 0).
  final num? value;

  /// Normal range minimum — in canonical unit.
  final num? normMin;

  /// Normal range maximum — in canonical unit.
  final num? normMax;

  /// Supported units. The first entry is the canonical unit.
  /// `null` means no unit label or switching.
  final List<UnitDefinition>? units;

  /// Index into [units] representing the unit currently shown to the user.
  /// 0 = canonical (default).
  final int activeUnitIndex;

  VariableNumber({
    required super.id,
    required super.name,
    required super.display,
    super.description,
    required this.value,
    required this.normMin,
    required this.normMax,
    this.units,
    this.activeUnitIndex = 0,
  }) : super(type: VariableType.number);

  /// The [UnitDefinition] currently active, or `null` if no units are defined.
  UnitDefinition? get activeUnit =>
      units != null && units!.isNotEmpty ? units![activeUnitIndex] : null;

  VariableNumber copyWith({
    num? Function()? value,
    num? normMin,
    num? normMax,
    List<UnitDefinition>? units,
    int? activeUnitIndex,
  }) {
    return VariableNumber(
      id: id,
      name: name,
      display: display,
      description: description,
      normMin: normMin ?? this.normMin,
      normMax: normMax ?? this.normMax,
      value: value != null ? value() : this.value,
      units: units ?? this.units,
      activeUnitIndex: activeUnitIndex ?? this.activeUnitIndex,
    );
  }
}

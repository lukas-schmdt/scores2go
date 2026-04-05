import 'package:scores_2_go/model/unit_definition.dart';
import 'package:scores_2_go/model/variable.dart';

class VariableSelection extends Variable {
  final List<VariableOption> options;
  final List<UnitDefinition>? units;
  final int activeUnitIndex;

  VariableSelection({
    required super.id,
    required super.name,
    required super.display,
    super.description,
    required super.type,
    required this.options,
    this.units,
    this.activeUnitIndex = 0,
  });

  UnitDefinition? get activeUnit =>
      units != null && units!.isNotEmpty ? units![activeUnitIndex] : null;

  VariableSelection copyWith({
    List<VariableOption>? options,
    List<UnitDefinition>? units,
    int? activeUnitIndex,
  }) {
    return VariableSelection(
      id: id,
      name: name,
      display: display,
      description: description,
      type: type,
      options: options ?? this.options,
      units: units ?? this.units,
      activeUnitIndex: activeUnitIndex ?? this.activeUnitIndex,
    );
  }
}

class VariableOption {
  final int id;
  final String display;
  final List<String>?
  displays; // per-unit labels, index-matched to parent units
  final num value;
  final String? description;
  final bool isSelected;

  VariableOption({
    required this.id,
    required this.display,
    this.displays,
    required this.value,
    this.description,
    this.isSelected = false,
  });

  VariableOption copyWith({
    int? id,
    String? display,
    List<String>? displays,
    num? value,
    String? description,
    bool? isSelected,
  }) {
    return VariableOption(
      id: id ?? this.id,
      display: display ?? this.display,
      displays: displays ?? this.displays,
      value: value ?? this.value,
      description: description ?? this.description,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

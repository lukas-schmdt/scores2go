enum VariableType { number, boolean, select, multiselect }

abstract class Variable {
  final String name;
  final String display;
  final String? description;
  final VariableType type;
  Variable({
    required this.name,
    required this.display,
    this.description,
    required this.type,
  });
}

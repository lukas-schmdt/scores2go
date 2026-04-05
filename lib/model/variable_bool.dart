import 'package:scores_2_go/model/variable.dart';

class VariableBool extends Variable {
  final bool? value;
  final num? trueValue;
  final num? falseValue;

  VariableBool({
    required super.id,
    required super.name,
    required super.display,
    super.description,
    required this.value,
    required this.trueValue,
    required this.falseValue,
  }) : super(type: VariableType.boolean);

  VariableBool copyWith({
    Object? value = _noValue,
    num? trueValue,
    num? falseValue,
  }) {
    return VariableBool(
      id: id,
      name: name,
      display: display,
      description: description,
      value: value == _noValue ? this.value : value as bool?,
      trueValue: trueValue ?? this.trueValue,
      falseValue: falseValue ?? this.falseValue,
    );
  }

  static const _noValue = Object();
}

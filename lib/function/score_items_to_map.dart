import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/variable.dart';
import 'package:scores_2_go/model/variable_bool.dart';
import 'package:scores_2_go/model/variable_number.dart';
import 'package:scores_2_go/model/variable_selection.dart';

class FlatScoreContext {
  final Score score;
  final Map<String, Variable> variablesByName;

  FlatScoreContext({required this.score})
    : variablesByName = {
        for (final group in score.groups)
          for (final variable in group.items) variable.name: variable,
      };

  /// Get numeric value (VariableNumber)
  Map<String, dynamic>? numValue(String name) {
    final v = variablesByName[name];
    if (v is VariableNumber) {
      if (v.value != null) {
        return {'value': v.value};
      }
    }
    return null;
  }

  /// Get boolean value (VariableBool)
  Map<String, dynamic>? boolValue(String name) {
    final v = variablesByName[name];
    if (v is VariableBool) {
      if (v.value != null) {
        return {
          'value': v.value,
          'points': v.value == true ? v.trueValue : v.falseValue,
        };
      }
    }
    return null;
  }

  Map<String, dynamic>? singleSelect(String name) {
    final v = variablesByName[name];
    if (v is VariableSelection && v.type == VariableType.select) {
      final selectedOption = v.options
          .where((option) => option.isSelected)
          .cast<VariableOption?>()
          .firstOrNull;
      if (selectedOption == null) return null;
      return {
        'display': selectedOption.display,
        'value': selectedOption.value,
      };
    }
    return null;
  }

  List<Map<String, dynamic>>? multiSelect(String name) {
    final v = variablesByName[name];
    var selectedOptions = <Map<String, dynamic>>[];

    if (v is VariableSelection) {
      for (final option in v.options) {
        if (option.isSelected) {
          selectedOptions.add({
            'display': option.display,
            'value': option.value,
          });
        }
      }
    }
    return selectedOptions.isNotEmpty ? selectedOptions : null;
  }
}

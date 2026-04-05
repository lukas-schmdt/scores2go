import 'package:scores_2_go_2/model/score.dart';
import 'package:scores_2_go_2/model/variable.dart';
import 'package:scores_2_go_2/model/variable_bool.dart';
import 'package:scores_2_go_2/model/variable_number.dart';
import 'package:scores_2_go_2/model/variable_selection.dart';

class FlatScoreContext {
  final Score score;
  final Map<int, Variable> variablesById;

  FlatScoreContext({required this.score})
    : variablesById = {
        for (final group in score.groups)
          for (final variable in group.items) variable.id: variable,
      };

  /// Get numeric value (VariableNumber)
  Map<String, dynamic>? numValue(int id) {
    final v = variablesById[id];
    if (v is VariableNumber) {
      if (v.value != null) {
        return {'value': v.value};
      }
    }
    return null;
  }

  /// Get boolean value (VariableBool)
  Map<String, dynamic>? boolValue(int id) {
    final v = variablesById[id];
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

  Map<String, dynamic>? singleSelectValueId(int id) {
    final v = variablesById[id];
    if (v is VariableSelection && v.type == VariableType.select) {
      final selectedOption = v.options
          .where((option) => option.isSelected)
          .cast<VariableOption?>()
          .firstOrNull;
      if (selectedOption == null) return null;
      return {
        'id': selectedOption.id,
        'display': selectedOption.display,
        'value': selectedOption.value,
      };
    }
    return null;
  }

  List<Map<String, dynamic>>? multiSelectValueIds(int id) {
    final v = variablesById[id];
    var selectedOptions = <Map<String, dynamic>>[];

    if (v is VariableSelection) {
      for (final option in v.options) {
        if (option.isSelected) {
          selectedOptions.add({
            'id': option.id,
            'display': option.display,
            'value': option.value,
          });
        }
      }
    }
    return selectedOptions.isNotEmpty ? selectedOptions : null;
  }
}

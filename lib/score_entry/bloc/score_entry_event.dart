part of 'score_entry_bloc.dart';

sealed class ScoreEntryEvent extends Equatable {
  const ScoreEntryEvent();

  @override
  List<Object> get props => [];
}

class ScoreEntryLoadEvent extends ScoreEntryEvent {
  final String scoreName;

  const ScoreEntryLoadEvent(this.scoreName);

  @override
  List<Object> get props => [scoreName];
}

class ScoreEntryUpdateBoolEvent extends ScoreEntryEvent {
  final String variableName;
  final bool value;

  const ScoreEntryUpdateBoolEvent(this.variableName, this.value);

  @override
  List<Object> get props => [variableName, value];
}

class ScoreEntryUpdateSelectionEvent extends ScoreEntryEvent {
  final String variableName;
  final VariableOption selectedOption;

  const ScoreEntryUpdateSelectionEvent(this.variableName, this.selectedOption);

  @override
  List<Object> get props => [variableName, selectedOption];
}

class ScoreEntryUpdateUnitEvent extends ScoreEntryEvent {
  final String variableName;
  final int unitIndex;

  const ScoreEntryUpdateUnitEvent(this.variableName, this.unitIndex);

  @override
  List<Object> get props => [variableName, unitIndex];
}

class ScoreEntryUpdateSelectionUnitEvent extends ScoreEntryEvent {
  final String variableName;
  final int unitIndex;

  const ScoreEntryUpdateSelectionUnitEvent(this.variableName, this.unitIndex);

  @override
  List<Object> get props => [variableName, unitIndex];
}

class ScoreEntryRecalculateEvent extends ScoreEntryEvent {
  const ScoreEntryRecalculateEvent();
}

class ScoreEntryUpdateNumberEvent extends ScoreEntryEvent {
  final String variableName;
  final num? newValue;

  const ScoreEntryUpdateNumberEvent(this.variableName, this.newValue);

  @override
  List<Object> get props => [variableName, ?newValue];
}

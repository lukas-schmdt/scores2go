part of 'score_entry_bloc.dart';

sealed class ScoreEntryEvent extends Equatable {
  const ScoreEntryEvent();

  @override
  List<Object> get props => [];
}

class ScoreEntryLoadEvent extends ScoreEntryEvent {
  final int scoreId;

  const ScoreEntryLoadEvent(this.scoreId);

  @override
  List<Object> get props => [scoreId];
}

class ScoreEntryUpdateBoolEvent extends ScoreEntryEvent {
  final int groupId;
  final int variableId;
  final bool value;

  const ScoreEntryUpdateBoolEvent(this.groupId, this.variableId, this.value);

  @override
  List<Object> get props => [groupId, variableId, value];
}

class ScoreEntryUpdateSelectionEvent extends ScoreEntryEvent {
  final int groupId;
  final int variableId;
  final VariableOption selectedOption;

  const ScoreEntryUpdateSelectionEvent(
    this.groupId,
    this.variableId,
    this.selectedOption,
  );

  @override
  List<Object> get props => [groupId, variableId, selectedOption];
}

class ScoreEntryUpdateUnitEvent extends ScoreEntryEvent {
  final int variableId;
  final int unitIndex;

  const ScoreEntryUpdateUnitEvent(this.variableId, this.unitIndex);

  @override
  List<Object> get props => [variableId, unitIndex];
}

class ScoreEntryUpdateSelectionUnitEvent extends ScoreEntryEvent {
  final int variableId;
  final int unitIndex;

  const ScoreEntryUpdateSelectionUnitEvent(this.variableId, this.unitIndex);

  @override
  List<Object> get props => [variableId, unitIndex];
}

class ScoreEntryRecalculateEvent extends ScoreEntryEvent {
  const ScoreEntryRecalculateEvent();
}

class ScoreEntryUpdateNumberEvent extends ScoreEntryEvent {
  final int groupId;
  final int variableId;
  final num? newValue;

  const ScoreEntryUpdateNumberEvent(
    this.groupId,
    this.variableId,
    this.newValue,
  );

  @override
  List<Object> get props => [
    groupId,
    variableId,
    // Only include newValue in the list if it is not null
    if (newValue != null) newValue!,
  ];
}

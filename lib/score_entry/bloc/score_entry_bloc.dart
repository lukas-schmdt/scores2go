import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/repo/scores_repository.dart';
import 'package:scores_2_go/model/score_result.dart';
import 'package:scores_2_go/model/variable.dart';
import 'package:scores_2_go/model/variable_bool.dart';
import 'package:scores_2_go/model/variable_number.dart';
import 'package:scores_2_go/model/variable_selection.dart';

part 'score_entry_event.dart';
part 'score_entry_state.dart';

class ScoreEntryBloc extends Bloc<ScoreEntryEvent, ScoreEntryState> {
  final ScoresRepository repo;

  ScoreEntryBloc(this.repo)
    : super(
        ScoreEntryState(
          status: Status.initial,
          score: Score(
            id: -1,
            name: '',
            groups: [],
            description: '',
            display: '',
          ),
        ),
      ) {
    on<ScoreEntryLoadEvent>(_onLoad);
    on<ScoreEntryUpdateBoolEvent>(_onUpdateBool);
    on<ScoreEntryUpdateSelectionEvent>(_onUpdateSelection);
    on<ScoreEntryUpdateNumberEvent>(_onUpdateNumber);
    on<ScoreEntryUpdateUnitEvent>(_onUpdateUnit);
    on<ScoreEntryUpdateSelectionUnitEvent>(_onUpdateSelectionUnit);
    on<ScoreEntryRecalculateEvent>(
      _onRecalculate,
      transformer: (events, mapper) =>
          events.debounce(const Duration(milliseconds: 500)).switchMap(mapper),
    );
  }

  ScoreResult? _compute(Score score) => score.scoreFunction?.call(score);

  Future<void> _onLoad(
    ScoreEntryLoadEvent event,
    Emitter<ScoreEntryState> emit,
  ) async {
    final matches = repo.scores.where((e) => e.name == event.scoreName);
    if (matches.isEmpty) {
      emit(state.copyWith(status: Status.error));
      return;
    }
    final score = matches.first;
    emit(ScoreEntryState(status: Status.loading, score: score));
    await Future.delayed(const Duration(seconds: 1));
    emit(
      ScoreEntryState(
        status: Status.success,
        score: score,
        scoreResult: _compute(score),
        isCalculating: false,
      ),
    );
  }

  void _onUpdateBool(
    ScoreEntryUpdateBoolEvent event,
    Emitter<ScoreEntryState> emit,
  ) {
    final score = state.score.copyWith(
      groups: state.score.groups.map((group) {
        return group.copyWith(
          items: group.items.map((variable) {
            if (variable is VariableBool &&
                variable.name == event.variableName) {
              return variable.copyWith(
                value: event.value != variable.value ? event.value : null,
              );
            }
            return variable;
          }).toList(),
        );
      }).toList(),
    );
    emit(state.copyWith(score: score, isCalculating: true));
    add(const ScoreEntryRecalculateEvent());
  }

  void _onUpdateSelection(
    ScoreEntryUpdateSelectionEvent event,
    Emitter<ScoreEntryState> emit,
  ) {
    final score = state.score.copyWith(
      groups: state.score.groups.map((group) {
        return group.copyWith(
          items: group.items.map((variable) {
            if (variable is VariableSelection &&
                variable.name == event.variableName) {
              if (variable.type == VariableType.multiselect) {
                return variable.copyWith(
                  options: variable.options.map((option) {
                    if (option == event.selectedOption) {
                      return option.copyWith(
                        isSelected: !event.selectedOption.isSelected,
                      );
                    }
                    return option;
                  }).toList(),
                );
              }
              if (variable.type == VariableType.select) {
                final isAlreadySelected = event.selectedOption.isSelected;
                return variable.copyWith(
                  options: variable.options.map((option) {
                    if (isAlreadySelected) {
                      return option.copyWith(isSelected: false);
                    }
                    return option.copyWith(
                      isSelected: option == event.selectedOption,
                    );
                  }).toList(),
                );
              }
            }
            return variable;
          }).toList(),
        );
      }).toList(),
    );
    emit(state.copyWith(score: score, isCalculating: true));
    add(const ScoreEntryRecalculateEvent());
  }

  void _onUpdateNumber(
    ScoreEntryUpdateNumberEvent event,
    Emitter<ScoreEntryState> emit,
  ) {
    final score = state.score.copyWith(
      groups: state.score.groups.map((group) {
        return group.copyWith(
          items: group.items.map((variable) {
            if (variable is VariableNumber &&
                variable.name == event.variableName) {
              return variable.copyWith(value: () => event.newValue);
            }
            return variable;
          }).toList(),
        );
      }).toList(),
    );
    emit(state.copyWith(score: score, isCalculating: true));
    add(const ScoreEntryRecalculateEvent());
  }

  void _onUpdateUnit(
    ScoreEntryUpdateUnitEvent event,
    Emitter<ScoreEntryState> emit,
  ) {
    final score = state.score.copyWith(
      groups: state.score.groups.map((group) {
        return group.copyWith(
          items: group.items.map((variable) {
            if (variable is VariableNumber &&
                variable.name == event.variableName) {
              return variable.copyWith(activeUnitIndex: event.unitIndex);
            }
            return variable;
          }).toList(),
        );
      }).toList(),
    );
    emit(state.copyWith(score: score));
  }

  void _onUpdateSelectionUnit(
    ScoreEntryUpdateSelectionUnitEvent event,
    Emitter<ScoreEntryState> emit,
  ) {
    final score = state.score.copyWith(
      groups: state.score.groups.map((group) {
        return group.copyWith(
          items: group.items.map((variable) {
            if (variable is VariableSelection &&
                variable.name == event.variableName) {
              return variable.copyWith(activeUnitIndex: event.unitIndex);
            }
            return variable;
          }).toList(),
        );
      }).toList(),
    );
    emit(state.copyWith(score: score));
  }

  Future<void> _onRecalculate(
    ScoreEntryRecalculateEvent event,
    Emitter<ScoreEntryState> emit,
  ) async {
    emit(
      state.copyWith(scoreResult: _compute(state.score), isCalculating: false),
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/model/score.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState(status: HomeStatus.initial, screenId: 0)) {
    on<HomeEvent>((event, emit) {
      if (event is SetScreenEvent) {
        emit(state.copyWith(screenId: event.screenId, clearSelectedScore: true));
      } else if (event is SelectScoreEvent) {
        emit(state.copyWith(selectedScore: event.score));
      } else if (event is ClearSelectedScoreEvent) {
        emit(state.copyWith(clearSelectedScore: true));
      }
    });
  }
}

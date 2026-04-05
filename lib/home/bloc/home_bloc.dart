import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(status: homeStatus.initial, screenId: 0)) {
    on<HomeEvent>((event, emit) {
      if (event is SetScreenEvent) {
        emit(state.copyWith(screenId: event.screenId));
      }
    });
  }
}

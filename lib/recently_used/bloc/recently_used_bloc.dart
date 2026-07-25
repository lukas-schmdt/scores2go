import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/repo/scores_repository.dart';

part 'recently_used_event.dart';
part 'recently_used_state.dart';

class RecentlyUsedBloc extends Bloc<RecentlyUsedEvent, RecentlyUsedState> {
  final ScoresRepository repo;
  RecentlyUsedBloc(this.repo)
    : super(
        RecentlyUsedState(
          status: RecentlyUsedStatus.initial,
          recentlyUsedScores: [],
        ),
      ) {
    on<RecentlyUsedEvent>((event, emit) async {
      if (event is LoadRecentlyUsedEvent) {
        final scoreNames = await repo.getRecentlyUsedScoreNames();
        final allScores = await repo.getScores();
        final byName = {for (final s in allScores) s.name: s};
        final scores = scoreNames
            .where((name) => byName.containsKey(name))
            .map((name) => byName[name]!)
            .toList();

        emit(
          state.copyWith(
            status: RecentlyUsedStatus.success,
            recentlyUsedScores: scores,
          ),
        );
      }
      if (event is JustUsedEvent) {
        const maxItems = 10;

        var names = List<String>.from(await repo.getRecentlyUsedScoreNames());

        names.remove(event.scoreName);
        names.insert(0, event.scoreName);

        if (names.length > maxItems) names = names.sublist(0, maxItems);

        await repo.addRecentlyUsedScoreName(names);

        final allScores = await repo.getScores();
        final byName = {for (final s in allScores) s.name: s};
        final ordered = [
          for (final name in names)
            if (byName[name] != null) byName[name]!,
        ];

        emit(state.copyWith(recentlyUsedScores: ordered));
      }
    });
  }
}

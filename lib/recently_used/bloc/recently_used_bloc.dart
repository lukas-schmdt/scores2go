import 'package:bloc/bloc.dart';
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
        var scoreIds = await repo.getRecentlyUsedScoreIds();
        var scores = (await repo.getScores())
            .where((score) => scoreIds.contains(score.id))
            .toList();

        var newScoresList = List<Score>.from(scores);

        print("Recently used scores:");
        scores.forEach((score) {
          print(score.id);
        });

        emit(
          state.copyWith(
            status: RecentlyUsedStatus.success,
            recentlyUsedScores: newScoresList,
          ),
        );
      }
      if (event is JustUsedEvent) {
        const maxItems = 10;

        // make a copy you can mutate
        var ids = List<int>.from(await repo.getRecentlyUsedScoreIds());

        // move used id to front
        ids.remove(event.scoreId);
        ids.insert(0, event.scoreId);

        // cap length
        if (ids.length > maxItems) ids = ids.sublist(0, maxItems);

        // (optional) persist ids
        await repo.addRecentlyUsedScoreId(ids);

        // build scores in the same order as ids
        final all = await repo.getScores();
        final byId = {for (final s in all) s.id: s};
        final ordered = <Score>[
          for (final id in ids)
            if (byId[id] != null) byId[id]!,
        ];

        emit(state.copyWith(recentlyUsedScores: ordered));
      }
    });
  }
}

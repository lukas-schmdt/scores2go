import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go_2/model/score.dart';
import 'package:scores_2_go_2/recently_used/bloc/recently_used_bloc.dart';
import 'package:scores_2_go_2/score_entry/Screen/score_entry_screen.dart';
import 'package:scores_2_go_2/score_entry/bloc/score_entry_bloc.dart';

void openScoreEntry(BuildContext context, Score score) {
  context.read<RecentlyUsedBloc>().add(JustUsedEvent(score.id));

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (_) => ScoreEntryBloc()..add(ScoreEntryLoadEvent(score.id)),
        child: ScoreEntryScreen(score: score),
      ),
    ),
  );
}

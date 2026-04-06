import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/recently_used/bloc/recently_used_bloc.dart';
import 'package:scores_2_go/score_entry/screen/score_entry_screen.dart';
import 'package:scores_2_go/score_entry/bloc/score_entry_bloc.dart';

void openScoreEntry(BuildContext context, Score score) {
  context.read<RecentlyUsedBloc>().add(JustUsedEvent(score.name));

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (_) => ScoreEntryBloc()..add(ScoreEntryLoadEvent(score.name)),
        child: ScoreEntryScreen(score: score),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/common/widget/empty_state.dart';
import 'package:scores_2_go/recently_used/bloc/recently_used_bloc.dart';
import 'package:scores_2_go/score_entry/screen/open_score_entry.dart';

class RecentlyUsedScreen extends StatelessWidget {
  const RecentlyUsedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecentlyUsedBloc, RecentlyUsedState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == RecentlyUsedStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == RecentlyUsedStatus.failure) {
          return const Center(child: Text('Fehler beim Laden der letzten Scores'));
        }

        if (state.recentlyUsedScores.isEmpty) {
          return const Scaffold(body: EmptyState.empty());
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Zuletzt verwendet')),
          body: ListView.builder(
            shrinkWrap: true,
            itemCount: state.recentlyUsedScores.length,
            itemBuilder: (context, index) {
              final score = state.recentlyUsedScores[index];
              return ListTile(
                leading: CircleAvatar(child: Text((index + 1).toString())),
                title: Text(
                  score.display,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(score.description),
                onTap: () => openScoreEntry(context, score),
              );
            },
          ),
        );
      },
    );
  }
}

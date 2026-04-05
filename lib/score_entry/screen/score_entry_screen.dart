import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/function/score_visibility_mapper.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_visibility.dart';
import 'package:scores_2_go/score_entry/bloc/score_entry_bloc.dart';
import 'package:scores_2_go/score_entry/widgets/group_widget.dart';
import 'package:scores_2_go/score_entry/widgets/progress_bar.dart';
import 'package:scores_2_go/score_entry/widgets/score_result_widget.dart';

class ScoreEntryScreen extends StatefulWidget {
  const ScoreEntryScreen({required this.score, super.key});

  final Score score;

  @override
  State<ScoreEntryScreen> createState() => _ScoreEntryScreenState();
}

class _ScoreEntryScreenState extends State<ScoreEntryScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _itemKeys = {};

  GlobalKey _keyFor(int variableId) =>
      _itemKeys.putIfAbsent(variableId, GlobalKey.new);

  void _scrollToVariable(int variableId) {
    final ctx = _itemKeys[variableId]?.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
      alignment: 0.1,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScoreEntryBloc, ScoreEntryState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == Status.initial) {
          return const Center(child: Text('Initialer Zustand'));
        } else if (state.status == Status.loading) {
          return const Material(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state.status == Status.error) {
          return const Center(child: Text('Fehler beim Laden des Scores'));
        } else if (state.status == Status.success) {
          final score = state.score;

          final visibilityFn = scoreVisibilityMapper[score.id];
          final visibility = visibilityFn != null
              ? visibilityFn(score)
              : const ScoreVisibility.all();

          return Scaffold(
            appBar: AppBar(title: Text(score.display)),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProgressBar(
                  score: score,
                  visibility: visibility,
                  onSegmentTap: _scrollToVariable,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (score.description.isNotEmpty)
                            Builder(builder: (context) {
                              final cs = Theme.of(context).colorScheme;
                              return Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: cs.primaryContainer,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: cs.primary.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.info_outline,
                                        size: 16, color: cs.primary),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        score.description,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: cs.onPrimaryContainer,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ...score.groups.map(
                            (group) => Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              clipBehavior: Clip.antiAlias,
                              child: GroupWidget(
                                group: group,
                                visibility: visibility,
                                itemKeys: _itemKeys,
                                keyFor: _keyFor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ScoreResultWidget(
                  scoreResult: state.scoreResult,
                  isLoading: state.isCalculating,
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('Unbekannter Zustand'));
        }
      },
    );
  }
}

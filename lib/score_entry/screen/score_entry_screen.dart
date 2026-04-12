import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/doc_formatting/markdown_parser.dart';
import 'package:url_launcher/url_launcher.dart';
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

class _ScoreEntryScreenState extends State<ScoreEntryScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _itemKeys = {};
  late final TabController _tabController;

  GlobalKey _keyFor(String variableName) =>
      _itemKeys.putIfAbsent(variableName, GlobalKey.new);

  void _scrollToVariable(String variableName) {
    final ctx = _itemKeys[variableName]?.currentContext;
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
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          final visibility =
              score.visibilityFunction?.call(score) ??
              const ScoreVisibility.all();

          final cs = Theme.of(context).colorScheme;

          return Scaffold(
            appBar: AppBar(
              title: Text(score.display),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: cs.outline, width: 0.5),
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: _tabController.index,
                onTap: _tabController.animateTo,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calculate_outlined),
                    activeIcon: Icon(Icons.calculate),
                    label: 'Score',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.article_outlined),
                    activeIcon: Icon(Icons.article),
                    label: 'Docs',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                // ── Score tab ────────────────────────────────────────────
                Column(
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
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                                  child: Text(
                                    score.description,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                                  ),
                                ),
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

                // ── Docs tab ─────────────────────────────────────────────
                score.doc != null && score.doc!.isNotEmpty
                    ? SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: parseMarkdown(
                            score.doc!,
                            onLinkTap: (url) async {
                              final uri = Uri.tryParse(url);
                              if (uri != null && await canLaunchUrl(uri)) {
                                await launchUrl(uri, mode: LaunchMode.externalApplication);
                              }
                            },
                          ),
                        ),
                      )
                    : const Center(
                        child: Text('No documentation available.'),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scores_2_go/model/score_visibility.dart';
import 'package:scores_2_go/score_entry/bloc/score_entry_bloc.dart';
import 'package:scores_2_go/score_entry/widgets/group_widget.dart';
import 'package:scores_2_go/score_entry/widgets/progress_bar.dart';
import 'package:scores_2_go/score_entry/widgets/score_result_widget.dart';

class ScoreEntryScreen extends StatefulWidget {
  const ScoreEntryScreen({required this.score, this.onClose, super.key});

  final Score score;
  final VoidCallback? onClose;

  @override
  State<ScoreEntryScreen> createState() => _ScoreEntryScreenState();
}

class _ScoreEntryScreenState extends State<ScoreEntryScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _itemKeys = {};

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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScoreEntryBloc, ScoreEntryState>(
      listener: (context, state) {},
      builder: (context, state) {
        final l = AppLocalizations.of(context)!;
        if (state.status == Status.initial) {
          return Center(child: Text(l.initialState));
        } else if (state.status == Status.loading) {
          return const Material(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state.status == Status.error) {
          return Center(child: Text(l.errorLoadingScore));
        } else if (state.status == Status.success) {
          final score = state.score;
          final visibility =
              score.visibilityFunction?.call(score) ??
              const ScoreVisibility.all();

          return Scaffold(
            appBar: AppBar(
              title: Text(score.display),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: widget.onClose ?? () => Navigator.of(context).pop(),
              ),
              actions: [
                if (score.docUrl != null)
                  Builder(
                    builder: (context) {
                      final locale = Localizations.localeOf(context).languageCode;
                      return _DocButton(
                        onTap: () async {
                          final url = score.docUrl!.call(locale);
                          if (url == null) return;
                          final uri = Uri.tryParse(url);
                          if (uri != null && await canLaunchUrl(uri)) {
                            await launchUrl(
                              uri,
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        },
                      );
                    },
                  ),
                const SizedBox(width: 4),
              ],
            ),
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                              child: Text(
                                score.description,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
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
          );
        } else {
          return Center(child: Text(l.unknownState));
        }
      },
    );
  }
}

class _DocButton extends StatelessWidget {
  const _DocButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.article_outlined,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

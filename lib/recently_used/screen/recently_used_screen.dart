import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/common/widget/empty_state.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/recently_used/bloc/recently_used_bloc.dart';
import 'package:scores_2_go/score_entry/screen/open_score_entry.dart';
import 'package:scores_2_go/theme/app_colors.dart';

class RecentlyUsedScreen extends StatelessWidget {
  const RecentlyUsedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return BlocConsumer<RecentlyUsedBloc, RecentlyUsedState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == RecentlyUsedStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == RecentlyUsedStatus.failure) {
          return Center(child: Text(l.errorLoadingRecentScores));
        }

        if (state.recentlyUsedScores.isEmpty) {
          return const Scaffold(body: EmptyState.empty());
        }

        return Scaffold(
          appBar: AppBar(title: Text(l.recentlyUsedTitle)),
          body: ListView.builder(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
            itemCount: state.recentlyUsedScores.length,
            itemBuilder: (context, index) {
              final score = state.recentlyUsedScores[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 6),
                child: InkWell(
                  onTap: () => openScoreEntry(context, score),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.blue, AppColors.teal],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                score.display,
                                style: tt.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (score.description.isNotEmpty) ...[
                                const SizedBox(height: 2),
                                Text(
                                  score.description,
                                  style: tt.bodySmall?.copyWith(
                                    color: cs.onSurfaceVariant,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: cs.onSurfaceVariant,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/common/widget/empty_state.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/score_entry/screen/open_score_entry.dart';
import 'package:scores_2_go/user_favorites/bloc/user_favorites_bloc.dart';

class UserFavoritesScreen extends StatelessWidget {
  const UserFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return BlocConsumer<UserFavoritesBloc, UserFavoritesState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == UserFavoritesStatus.loading) {
          return Scaffold(
            appBar: AppBar(title: Text(l.favoritesTitle)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == UserFavoritesStatus.error) {
          return Scaffold(
            appBar: AppBar(title: Text(l.favoritesTitle)),
            body: Center(child: Text(l.errorLoadingFavorites)),
          );
        }

        if (state.favorites.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text(l.favoritesTitle)),
            body: const EmptyState.empty(),
          );
        }

        final scores = state.scores;

        return Scaffold(
          appBar: AppBar(title: Text(l.favoritesTitle)),
          body: ReorderableListView.builder(
            buildDefaultDragHandles: false,
            itemCount: state.favorites.length,
            onReorder: (oldIndex, newIndex) {
              context.read<UserFavoritesBloc>().add(
                ReorderFavoriteEvent(oldIndex, newIndex),
              );
            },
            itemBuilder: (context, index) {
              final favId = state.favorites[index];
              final score = scores.firstWhere((s) => s.id == favId);
              final cs = Theme.of(context).colorScheme;
              final tt = Theme.of(context).textTheme;

              return Dismissible(
                key: Key('fav_$favId'),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  context
                      .read<UserFavoritesBloc>()
                      .add(RemoveUserFavoriteEvent(favId));
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.delete, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        l.delete,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                child: Card(
                  key: Key('reorder_$favId'),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  elevation: 2,
                  child: InkWell(
                    onTap: () => openScoreEntry(context, score),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
                      child: Row(
                        children: [
                          ReorderableDragStartListener(
                            index: index,
                            child: Icon(
                              Icons.drag_handle,
                              color: cs.onSurfaceVariant,
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
                                  const SizedBox(height: 4),
                                  Text(
                                    score.description,
                                    style: tt.bodySmall?.copyWith(
                                      color: cs.onSurfaceVariant,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                                if (score.author != null ||
                                    score.year != null) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    child: Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: cs.outlineVariant,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.person_outline,
                                        size: 12,
                                        color: cs.onSurfaceVariant,
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        [
                                          if (score.author != null)
                                            score.author!,
                                          if (score.year != null)
                                            '${score.year}',
                                        ].join(', '),
                                        style: tt.labelSmall?.copyWith(
                                          color: cs.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Icon(
                            Icons.swipe_left_outlined,
                            color: cs.onSurfaceVariant,
                          ),
                        ],
                      ),
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

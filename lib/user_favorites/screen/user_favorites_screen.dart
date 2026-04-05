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
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == UserFavoritesStatus.error) {
          return Center(child: Text(l.errorLoadingFavorites));
        }

        if (state.favorites.isEmpty) {
          return const Scaffold(body: EmptyState.empty());
        }

        final scores = state.scores;

        return Scaffold(
          appBar: AppBar(title: Text(l.favoritesTitle)),
          body: ReorderableListView.builder(
            buildDefaultDragHandles: false,
            shrinkWrap: true,
            itemCount: state.favorites.length,
            onReorder: (oldIndex, newIndex) {
              context.read<UserFavoritesBloc>().add(
                    ReorderFavoriteEvent(oldIndex, newIndex),
                  );
            },
            itemBuilder: (context, index) {
              final favId = state.favorites[index];
              final score = scores.firstWhere((s) => s.id == favId);

              return ReorderableDragStartListener(
                key: Key('reorder_$favId'),
                index: index,
                child: Dismissible(
                  key: Key(favId.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) {
                    context.read<UserFavoritesBloc>().add(
                          RemoveUserFavoriteEvent(favId),
                        );
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
                        Text(l.delete,
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.drag_handle),
                    trailing: const Icon(Icons.swipe_left_outlined),
                    title: Text(
                      score.display,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(score.description),
                    onTap: () => openScoreEntry(context, score),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/collections/bloc/collections_bloc.dart';
import 'package:scores_2_go/collections/widget/create_collection_dialog.dart';
import 'package:scores_2_go/home/provide_home_blocs.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/model/score_collection.dart';
import 'package:scores_2_go/user_favorites/bloc/user_favorites_bloc.dart';

/// Shows a dialog for saving a score to Favorites and/or any collection.
/// The caller must make sure the user is signed in.
Future<void> showSaveToDialog(BuildContext context, int scoreId) {
  return showDialog<void>(
    context: context,
    builder: (_) =>
        provideHomeBlocs(context, _SaveToDialog(scoreId: scoreId)),
  );
}

class _SaveToDialog extends StatelessWidget {
  const _SaveToDialog({required this.scoreId});

  final int scoreId;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return BlocBuilder<CollectionsBloc, CollectionsState>(
      builder: (context, state) {
        return AlertDialog(
          title: Text(l.saveTo),
          insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
          content: SizedBox(
            width: 320,
            child: ListView(
              shrinkWrap: true,
              children: [
                _FavoriteTile(scoreId: scoreId),
                const Divider(),
                if (state.status == CollectionsStatus.loading)
                  const SizedBox(
                    height: 80,
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state.collections.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(l.noCollectionsYet),
                  )
                else
                  for (final collection in state.collections)
                    _CollectionTile(collection: collection, scoreId: scoreId),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => showCreateCollectionDialog(context),
              child: Text(l.newCollection),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l.done),
            ),
          ],
        );
      },
    );
  }
}

class _FavoriteTile extends StatelessWidget {
  const _FavoriteTile({required this.scoreId});

  final int scoreId;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return BlocBuilder<UserFavoritesBloc, UserFavoritesState>(
      builder: (context, state) {
        final isFavorite = state.favorites.contains(scoreId);
        return CheckboxListTile(
          value: isFavorite,
          secondary: const Icon(Icons.star, color: Colors.amber),
          title: Text(l.favoritesTitle),
          controlAffinity: ListTileControlAffinity.trailing,
          onChanged: state.pendingId == scoreId
              ? null
              : (_) {
                  context.read<UserFavoritesBloc>().add(
                    isFavorite
                        ? RemoveUserFavoriteEvent(scoreId)
                        : AddUserFavoriteEvent(scoreId),
                  );
                },
        );
      },
    );
  }
}

class _CollectionTile extends StatelessWidget {
  const _CollectionTile({required this.collection, required this.scoreId});

  final ScoreCollection collection;
  final int scoreId;

  @override
  Widget build(BuildContext context) {
    final isIn = collection.scoreIds.contains(scoreId);
    return CheckboxListTile(
      value: isIn,
      secondary: Icon(
        Icons.folder_outlined,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(collection.display),
      controlAffinity: ListTileControlAffinity.trailing,
      onChanged: (_) {
        if (isIn) {
          context.read<CollectionsBloc>().add(
            RemoveScoreFromCollectionEvent(collection.id, scoreId),
          );
        } else {
          context.read<CollectionsBloc>().add(
            AddScoreToCollectionEvent(collection.id, scoreId),
          );
        }
      },
    );
  }
}

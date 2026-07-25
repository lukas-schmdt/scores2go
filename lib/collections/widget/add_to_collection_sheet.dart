import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/collections/bloc/collections_bloc.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/model/score_collection.dart';

/// Shows a centered dialog for adding a score to a collection.
Future<void> showAddToCollectionDialog(BuildContext context, int scoreId) {
  return showDialog<void>(
    context: context,
    builder: (_) => BlocProvider.value(
      value: context.read<CollectionsBloc>(),
      child: _AddToCollectionDialog(scoreId: scoreId),
    ),
  );
}

class _AddToCollectionDialog extends StatelessWidget {
  const _AddToCollectionDialog({required this.scoreId});

  final int scoreId;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return BlocBuilder<CollectionsBloc, CollectionsState>(
      builder: (context, state) {
        return AlertDialog(
          title: Text(l.addToCollection),
          insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
          content: SizedBox(
            width: 320,
            child: state.status == CollectionsStatus.loading
                ? const SizedBox(
                    height: 80,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : state.collections.isEmpty
                    ? Text(l.noCollectionsYet)
                    : ListView(
                        shrinkWrap: true,
                        children: [
                          for (final collection in state.collections)
                            _CollectionTile(
                              collection: collection,
                              scoreId: scoreId,
                            ),
                        ],
                      ),
          ),
          actions: [
            TextButton(
              onPressed: () => _showCreateDialog(context),
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

  Future<void> _showCreateDialog(BuildContext context) async {
    final bloc = context.read<CollectionsBloc>();
    final l = AppLocalizations.of(context)!;
    final controller = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.newCollection),
        content: SizedBox(
          width: 320,
          child: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: l.collectionNameHint,
              border: const OutlineInputBorder(),
              isDense: true,
            ),
            textCapitalization: TextCapitalization.sentences,
            onSubmitted: (_) => Navigator.of(ctx).pop(true),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l.create),
          ),
        ],
      ),
    );
    if (confirmed == true && controller.text.trim().isNotEmpty) {
      bloc.add(CreateCollectionEvent(controller.text.trim()));
    }
    controller.dispose();
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

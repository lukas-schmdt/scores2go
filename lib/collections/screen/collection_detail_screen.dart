import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/collections/bloc/collections_bloc.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_collection.dart';
import 'package:scores_2_go/repo/scores_repository.dart';
import 'package:scores_2_go/score_entry/screen/open_score_entry.dart';

class CollectionDetailScreen extends StatelessWidget {
  const CollectionDetailScreen({super.key, required this.collectionId});

  final int collectionId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionsBloc, CollectionsState>(
      builder: (context, state) {
        final collection = state.collections
            .where((c) => c.id == collectionId)
            .firstOrNull;

        if (collection == null) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => Navigator.of(context).maybePop(),
          );
          return const Scaffold(body: SizedBox.shrink());
        }

        final allScores = context.read<ScoresRepository>().scores;
        final scores = collection.scoreIds
            .map((id) => allScores.where((s) => s.id == id).firstOrNull)
            .whereType<Score>()
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(collection.display),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: 'Rename',
                onPressed: () => _showRenameDialog(context, collection),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: 'Delete collection',
                onPressed: () => _confirmDelete(context, collection),
              ),
            ],
          ),
          body: scores.isEmpty
              ? const Center(
                  child: Text(
                    'No scores in this collection yet.\nAdd scores from the Browse tab.',
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
                  itemCount: scores.length,
                  itemBuilder: (context, index) {
                    final score = scores[index];
                    final cs = Theme.of(context).colorScheme;
                    final tt = Theme.of(context).textTheme;
                    return Dismissible(
                      key: Key('col_score_${score.id}'),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) {
                        context.read<CollectionsBloc>().add(
                          RemoveScoreFromCollectionEvent(
                            collection.id,
                            score.id,
                          ),
                        );
                      },
                      background: Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 6),
                        elevation: 2,
                        child: InkWell(
                          onTap: () => openScoreEntry(context, score),
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              vertical: 8),
                                          child: Divider(
                                            height: 1,
                                            thickness: 1,
                                            color: cs.outlineVariant,
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.person_outline,
                                                size: 12,
                                                color: cs.onSurfaceVariant),
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
                                  size: 18,
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

  Future<void> _showRenameDialog(
    BuildContext context,
    ScoreCollection collection,
  ) async {
    final bloc = context.read<CollectionsBloc>();
    final controller = TextEditingController(text: collection.display);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Rename collection'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
          ),
          onSubmitted: (_) => Navigator.of(ctx).pop(true),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (confirmed == true && controller.text.trim().isNotEmpty) {
      bloc.add(RenameCollectionEvent(collection.id, controller.text.trim()));
    }
    controller.dispose();
  }

  Future<void> _confirmDelete(
    BuildContext context,
    ScoreCollection collection,
  ) async {
    final bloc = context.read<CollectionsBloc>();
    final nav = Navigator.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete collection?'),
        content: Text(
          '"${collection.display}" will be deleted. Scores are not affected.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      bloc.add(DeleteCollectionEvent(collection.id));
      nav.pop();
    }
  }
}

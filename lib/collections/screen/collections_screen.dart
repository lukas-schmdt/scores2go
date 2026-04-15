import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/collections/bloc/collections_bloc.dart';
import 'package:scores_2_go/collections/screen/collection_detail_screen.dart';
import 'package:scores_2_go/common/layout/breakpoints.dart';
import 'package:scores_2_go/common/widget/empty_state.dart';
import 'package:scores_2_go/model/score_collection.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionsBloc, CollectionsState>(
      builder: (context, state) {
        final collections = state.collections;
        final isMobile = MediaQuery.of(context).size.width < kMobileBreakpoint;

        return Scaffold(
          appBar: AppBar(title: const Text('Collections')),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showCreateDialog(context),
            child: const Icon(Icons.add),
          ),
          body: state.status == CollectionsStatus.loading
              ? const Center(child: CircularProgressIndicator())
              : collections.isEmpty
              ? const EmptyState.empty()
              : isMobile
              ? _Grid(collections: collections)
              : _List(collections: collections),
        );
      },
    );
  }

  Future<void> _showCreateDialog(BuildContext context) async {
    final bloc = context.read<CollectionsBloc>();
    final controller = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New collection'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Collection name',
            border: OutlineInputBorder(),
            isDense: true,
          ),
          textCapitalization: TextCapitalization.sentences,
          onSubmitted: (_) => Navigator.of(ctx).pop(true),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Create'),
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

void _openDetail(BuildContext context, int collectionId) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: context.read<CollectionsBloc>(),
        child: CollectionDetailScreen(collectionId: collectionId),
      ),
    ),
  );
}

// ─── 2-column grid (mobile) ───────────────────────────────────────────────────

class _Grid extends StatelessWidget {
  const _Grid({required this.collections});

  final List<ScoreCollection> collections;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 96),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        mainAxisExtent: 72,
      ),
      itemCount: collections.length,
      itemBuilder: (context, index) {
        final collection = collections[index];
        final count = collection.scoreIds.length;
        return Card(
          elevation: 2,
          child: InkWell(
            onTap: () => _openDetail(context, collection.id),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              child: Row(
                children: [
                  Icon(Icons.folder_outlined, color: cs.primary, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          collection.display,
                          style: tt.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$count score${count == 1 ? '' : 's'}',
                          style: tt.bodySmall?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─── List (wide layout) ───────────────────────────────────────────────────────

class _List extends StatelessWidget {
  const _List({required this.collections});

  final List<ScoreCollection> collections;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 96),
      itemCount: collections.length,
      itemBuilder: (context, index) {
        final collection = collections[index];
        final count = collection.scoreIds.length;
        return Card(
          margin: const EdgeInsets.only(bottom: 6),
          elevation: 2,
          child: InkWell(
            onTap: () => _openDetail(context, collection.id),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  Icon(Icons.folder_outlined, color: cs.primary, size: 28),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          collection.display,
                          style: tt.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$count score${count == 1 ? '' : 's'}',
                          style: tt.bodySmall?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                        ),
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
    );
  }
}

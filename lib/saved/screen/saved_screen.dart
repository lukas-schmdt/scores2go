import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/auth/bloc/auth_bloc.dart';
import 'package:scores_2_go/auth/screen/open_auth_screen.dart';
import 'package:scores_2_go/collections/bloc/collections_bloc.dart';
import 'package:scores_2_go/collections/screen/collection_detail_screen.dart';
import 'package:scores_2_go/collections/widget/create_collection_dialog.dart';
import 'package:scores_2_go/common/layout/breakpoints.dart';
import 'package:scores_2_go/common/widget/empty_state.dart';
import 'package:scores_2_go/home/provide_home_blocs.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_collection.dart';
import 'package:scores_2_go/score_entry/screen/open_score_entry.dart';
import 'package:scores_2_go/user_favorites/bloc/user_favorites_bloc.dart';

/// "Saved" tab: Favorites (always expanded, one tap to a score) on top,
/// the user's collections below.
class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    if (!context.watch<AuthBloc>().state.isAuthenticated) {
      return Scaffold(
        appBar: AppBar(title: Text(l.navSaved)),
        body: EmptyState(
          iconData: Icons.lock_outline,
          title: l.signInRequiredTitle,
          subtitle: l.savedSignInSubtitle,
          action: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: FilledButton(
              onPressed: () => openAuthScreen(context),
              child: Text(l.login),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l.navSaved)),
      body: CustomScrollView(
        slivers: [
          _SectionHeader(
            icon: Icons.folder,
            iconColor: Theme.of(context).colorScheme.primary,
            title: l.collectionsTitle,
            action: TextButton.icon(
              onPressed: () => showCreateCollectionDialog(context),
              icon: const Icon(Icons.add, size: 18),
              label: Text(l.newCollection),
            ),
          ),
          const _CollectionsSection(),
          _SectionHeader(
            icon: Icons.star,
            iconColor: Colors.amber,
            title: l.favoritesTitle,
          ),
          const _FavoritesSection(),
          const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
        ],
      ),
    );
  }
}

// ─── Section chrome ───────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.action,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 8, 4),
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              ?action,
            ],
          ),
        ),
      ),
    );
  }
}

/// Inline hint / status line shown in place of a section's content.
class _SectionMessage extends StatelessWidget {
  const _SectionMessage(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _SectionLoading extends StatelessWidget {
  const _SectionLoading();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

// ─── Favorites ────────────────────────────────────────────────────────────────

class _FavoritesSection extends StatelessWidget {
  const _FavoritesSection();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return BlocBuilder<UserFavoritesBloc, UserFavoritesState>(
      builder: (context, state) {
        if (state.status == UserFavoritesStatus.initial ||
            state.status == UserFavoritesStatus.loading) {
          return const _SectionLoading();
        }

        if (state.status == UserFavoritesStatus.error) {
          return _SectionMessage(l.errorLoadingFavorites);
        }

        if (state.favorites.isEmpty) {
          return _SectionMessage(l.favoritesEmptyHint);
        }

        return SliverReorderableList(
          itemCount: state.favorites.length,
          onReorder: (oldIndex, newIndex) {
            context.read<UserFavoritesBloc>().add(
              ReorderFavoriteEvent(oldIndex, newIndex),
            );
          },
          itemBuilder: (context, index) {
            final favId = state.favorites[index];
            final score = state.scores.where((s) => s.id == favId).firstOrNull;
            if (score == null) {
              // Favourite id with no matching score (e.g. removed score);
              // skip rendering it rather than crash the list.
              return SizedBox.shrink(key: Key('fav_missing_$favId'));
            }
            return _FavoriteCard(
              key: Key('fav_$favId'),
              score: score,
              index: index,
            );
          },
        );
      },
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  const _FavoriteCard({super.key, required this.score, required this.index});

  final Score score;
  final int index;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Dismissible(
      key: Key('fav_dismiss_${score.id}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        context.read<UserFavoritesBloc>().add(
          RemoveUserFavoriteEvent(score.id),
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
            Text(l.delete, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                  child: Icon(Icons.drag_handle, color: cs.onSurfaceVariant),
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
                      if (score.author != null || score.year != null) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
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
                                if (score.author != null) score.author!,
                                if (score.year != null) '${score.year}',
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
                Icon(Icons.swipe_left_outlined, color: cs.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Collections ──────────────────────────────────────────────────────────────

class _CollectionsSection extends StatelessWidget {
  const _CollectionsSection();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return BlocBuilder<CollectionsBloc, CollectionsState>(
      builder: (context, state) {
        if (state.status == CollectionsStatus.initial ||
            state.status == CollectionsStatus.loading) {
          return const _SectionLoading();
        }

        final collections = state.collections;
        if (collections.isEmpty) {
          return _SectionMessage(l.collectionsEmptyHint);
        }

        final isMobile = MediaQuery.of(context).size.width < kMobileBreakpoint;
        return isMobile
            ? _CollectionsGrid(collections: collections)
            : _CollectionsList(collections: collections);
      },
    );
  }
}

void _openDetail(BuildContext context, int collectionId) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => provideHomeBlocs(
        context,
        CollectionDetailScreen(collectionId: collectionId),
      ),
    ),
  );
}

// 2-column grid (mobile)
class _CollectionsGrid extends StatelessWidget {
  const _CollectionsGrid({required this.collections});

  final List<ScoreCollection> collections;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          mainAxisExtent: 72,
        ),
        itemCount: collections.length,
        itemBuilder: (context, index) {
          final collection = collections[index];
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
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            l.collectionScoreCount(collection.scoreIds.length),
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
      ),
    );
  }
}

// List (wide layout)
class _CollectionsList extends StatelessWidget {
  const _CollectionsList({required this.collections});

  final List<ScoreCollection> collections;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
      sliver: SliverList.builder(
        itemCount: collections.length,
        itemBuilder: (context, index) {
          final collection = collections[index];
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
                            l.collectionScoreCount(collection.scoreIds.length),
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
      ),
    );
  }
}

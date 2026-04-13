import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/common/layout/breakpoints.dart';
import 'package:scores_2_go/common/widget/empty_state.dart';
import 'package:scores_2_go/home/bloc/home_bloc.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/recently_used/screen/recently_used_screen.dart';
import 'package:scores_2_go/repo/scores_repository.dart';
import 'package:scores_2_go/score_entry/bloc/score_entry_bloc.dart';
import 'package:scores_2_go/score_entry/screen/score_entry_screen.dart';
import 'package:scores_2_go/score_list/bloc/scores_bloc.dart';
import 'package:scores_2_go/score_list/screen/score_list_screen.dart';
import 'package:scores_2_go/settings/screen/settings_screen.dart';
import 'package:scores_2_go/user_favorites/screen/user_favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildContent(BuildContext context, int screenId) {
    return switch (screenId) {
      0 => BlocProvider(
        create: (context) =>
            ScoresBloc(context.read<ScoresRepository>())
              ..add(LoadScoresEvent()),
        child: const ScoreListScreen(),
      ),
      1 => const UserFavoritesScreen(),
      2 => const RecentlyUsedScreen(),
      3 => const SettingsScreen(),
      _ => Scaffold(body: EmptyState.error()),
    };
  }

  Widget _buildDetailPanel(
    BuildContext context,
    Score score,
    VoidCallback onClose,
  ) {
    final repo = context.read<ScoresRepository>();
    return BlocProvider(
      key: ValueKey(score.name),
      create: (_) => ScoreEntryBloc(repo)..add(ScoreEntryLoadEvent(score.name)),
      child: ScoreEntryScreen(score: score, onClose: onClose),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        void onNavTap(int index) =>
            context.read<HomeBloc>().add(SetScreenEvent(screenId: index));

        void onClose() =>
            context.read<HomeBloc>().add(ClearSelectedScoreEvent());

        final navItems = [
          (
            icon: Icons.grid_view_outlined,
            activeIcon: Icons.grid_view,
            label: l.navBrowse,
          ),
          (
            icon: Icons.star_outline,
            activeIcon: Icons.star,
            label: l.navFavorites,
          ),
          (
            icon: Icons.history,
            activeIcon: Icons.history,
            label: l.navRecentlyUsed,
          ),
          (
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: l.navProfile,
          ),
        ];

        final railDestinations = [
          for (final item in navItems)
            NavigationRailDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.activeIcon),
              label: Text(item.label),
            ),
        ];

        final bottomItems = [
          for (final item in navItems)
            BottomNavigationBarItem(
              icon: Icon(item.icon),
              activeIcon: Icon(item.activeIcon),
              label: item.label,
            ),
        ];

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final isWide = width >= kMobileBreakpoint;
            final isExtended = width >= kWideBreakpoint;
            final hasDetail = state.selectedScore != null;

            // ── Mobile layout ────────────────────────────────────────────
            if (!isWide) {
              return Scaffold(
                bottomNavigationBar: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: cs.outline, width: 0.5),
                    ),
                  ),
                  child: BottomNavigationBar(
                    currentIndex: state.screenId,
                    onTap: onNavTap,
                    items: bottomItems,
                  ),
                ),
                body: _buildContent(context, state.screenId),
              );
            }

            // ── Wide layout ──────────────────────────────────────────────
            final rail = NavigationRail(
              selectedIndex: state.screenId,
              onDestinationSelected: onNavTap,
              extended: isExtended,
              labelType: isExtended
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.all,
              destinations: railDestinations,
            );

            final divider = VerticalDivider(
              width: 1,
              thickness: 0.5,
              color: cs.outline,
            );

            final content = _buildContent(context, state.screenId);

            return Scaffold(
              body: Row(
                children: [
                  rail,
                  divider,
                  // Left panel — list / screen content
                  if (hasDetail)
                    SizedBox(width: 380, child: content)
                  else
                    Expanded(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 900),
                          child: content,
                        ),
                      ),
                    ),
                  // Right panel — score entry detail
                  if (hasDetail) ...[
                    divider,
                    Expanded(
                      child: _buildDetailPanel(
                        context,
                        state.selectedScore!,
                        onClose,
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}

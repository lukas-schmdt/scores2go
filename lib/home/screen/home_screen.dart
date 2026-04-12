import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/common/widget/empty_state.dart';
import 'package:scores_2_go/home/bloc/home_bloc.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/recently_used/screen/recently_used_screen.dart';
import 'package:scores_2_go/scores/bloc/scores_bloc.dart';
import 'package:scores_2_go/repo/scores_repository.dart';
import 'package:scores_2_go/scores/screen/scores_screen.dart';
import 'package:scores_2_go/settings/screen/settings_screen.dart';
import 'package:scores_2_go/user_favorites/screen/user_favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: cs.outline, width: 0.5),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: state.screenId,
              onTap: (value) =>
                  context.read<HomeBloc>().add(SetScreenEvent(screenId: value)),
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.grid_view_outlined),
                  activeIcon: const Icon(Icons.grid_view),
                  label: l.navBrowse,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.star_outline),
                  activeIcon: const Icon(Icons.star),
                  label: l.navFavorites,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.history),
                  label: l.navRecentlyUsed,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person_outline),
                  activeIcon: const Icon(Icons.person),
                  label: l.navProfile,
                ),
              ],
            ),
          ),
          body: state.screenId == 0
              ? BlocProvider(
                  create: (context) =>
                      ScoresBloc(context.read<ScoresRepository>())
                        ..add(LoadScoresEvent()),
                  child: const ScoresScreen(),
                )
              : state.screenId == 1
              ? const UserFavoritesScreen()
              : state.screenId == 2
              ? const RecentlyUsedScreen()
              : state.screenId == 3
              ? const SettingsScreen()
              : EmptyState.error(),
        );
      },
    );
  }
}

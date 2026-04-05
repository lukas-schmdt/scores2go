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

enum Feature {
  allScores(0),
  favorites(1),
  recentlyUsed(2),
  profile(3);

  const Feature(this.value);
  final int value;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return BlocConsumer<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(toolbarHeight: 12),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.screenId,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              context.read<HomeBloc>().add(SetScreenEvent(screenId: value));
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.grid_view),
                label: l.navBrowse,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.star),
                label: l.navFavorites,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.history),
                label: l.navRecentlyUsed,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: l.navProfile,
              ),
            ],
          ),
          body: state.screenId == 0
              ? BlocProvider(
                  create: (context) =>
                      ScoresBloc(context.read<ScoresRepository>())
                        ..add(LoadScoresEvent()),
                  child: ScoresScreen(),
                )
              : state.screenId == 1
              ? UserFavoritesScreen()
              : state.screenId == 2
              ? RecentlyUsedScreen()
              : state.screenId == 3
              ? SettingsScreen()
              : EmptyState.error(),
        );
      },
      listener: (context, state) {},
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go_2/common/widget/empty_state.dart';
import 'package:scores_2_go_2/home/bloc/home_bloc.dart';
import 'package:scores_2_go_2/recently_used/screen/recently_used_screen.dart';
import 'package:scores_2_go_2/scores/bloc/scores_bloc.dart';
import 'package:scores_2_go_2/repo/scores_repository.dart';
import 'package:scores_2_go_2/scores/screen/scores_screen.dart';
import 'package:scores_2_go_2/settings/screen/settings_screen.dart';
import 'package:scores_2_go_2/user_favorites/screen/user_favorites_screen.dart';

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
                icon: Icon(Icons.grid_view),
                label: 'Browse',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'Recently used',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
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
      listener: (context, state) {
        //TODO: Integrate Navigation to ScoreEntryScreen
      },
    );
  }
}

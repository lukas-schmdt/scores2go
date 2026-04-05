import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/auth/bloc/auth_bloc.dart';
import 'package:scores_2_go/auth/screen/auth_screen.dart';
import 'package:scores_2_go/auth/screen/reset_password_screen.dart';
import 'package:scores_2_go/home/bloc/home_bloc.dart';
import 'package:scores_2_go/home/screen/home_screen.dart';
import 'package:scores_2_go/recently_used/bloc/recently_used_bloc.dart';
import 'package:scores_2_go/data_provider/scores_data_provider.dart';
import 'package:scores_2_go/repo/scores_repository.dart';
import 'package:scores_2_go/settings/bloc/settings_bloc.dart';
import 'package:scores_2_go/user_favorites/bloc/user_favorites_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const supabaseUrl = 'https://uvyubzssdgahfhnpmrmv.supabase.co';
  const supabaseAnonKey = 'sb_publishable_cn_ImkBZFYSlFPltyHCUPQ_AgX3CJm8';

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  final scoresDataProvider = ScoresDataProvider();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ScoresRepository(scoresDataProvider),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc()..add(getAppVersion()),
          ),
          BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        ],
        child: Scores2GoApp(),
      ),
    ),
  );
}

class Scores2GoApp extends StatelessWidget {
  Scores2GoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scoresRepo = context.read<ScoresRepository>();

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (settingsContext, settingsState) => MaterialApp(
        title: 'Scores2Go',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        themeMode: settingsState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (authContext, authState) {
            if (authState.status == AuthStatus.authenticated) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
                  BlocProvider<UserFavoritesBloc>(
                    create: (context) =>
                        UserFavoritesBloc(scoresRepo)
                          ..add(const LoadUserFavoritesEvent()),
                  ),
                  BlocProvider<RecentlyUsedBloc>(
                    create: (context) =>
                        RecentlyUsedBloc(scoresRepo)
                          ..add(LoadRecentlyUsedEvent()),
                  ),
                ],
                child: HomeScreen(),
              );
            } else if (authState.status == AuthStatus.passwordRecovery) {
              return const ResetPasswordScreen();
            } else {
              return const AuthScreen();
            }
          },
        ),
      ),
    );
  }
}

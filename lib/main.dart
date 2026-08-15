import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/auth/bloc/auth_bloc.dart';
import 'package:scores_2_go/auth/screen/reset_password_screen.dart';
import 'package:scores_2_go/home/bloc/home_bloc.dart';
import 'package:scores_2_go/home/screen/home_screen.dart';
import 'package:scores_2_go/recently_used/bloc/recently_used_bloc.dart';
import 'package:scores_2_go/collections/bloc/collections_bloc.dart';
import 'package:scores_2_go/data_provider/collections_data_provider.dart';
import 'package:scores_2_go/data_provider/feedback_data_provider.dart';
import 'package:scores_2_go/data_provider/scores_data_provider.dart';
import 'package:scores_2_go/repo/collections_repository.dart';
import 'package:scores_2_go/repo/feedback_repository.dart';
import 'package:scores_2_go/repo/scores_repository.dart';
import 'package:scores_2_go/settings/bloc/settings_bloc.dart';
import 'package:scores_2_go/theme/theme_data.dart';
import 'package:scores_2_go/user_favorites/bloc/user_favorites_bloc.dart';
import 'package:scores_2_go/deep_link/deep_link_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DeepLinkService.init();


  const supabaseUrl = 'https://uvyubzssdgahfhnpmrmv.supabase.co';
  const supabaseAnonKey = 'sb_publishable_cn_ImkBZFYSlFPltyHCUPQ_AgX3CJm8';

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  final scoresDataProvider = ScoresDataProvider();
  final feedbackDataProvider = FeedbackDataProvider();
  final collectionsDataProvider = CollectionsDataProvider();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ScoresRepository(scoresDataProvider),
        ),
        RepositoryProvider(
          create: (context) => FeedbackRepository(feedbackDataProvider),
        ),
        RepositoryProvider(
          create: (context) =>
              CollectionsRepository(collectionsDataProvider),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc()..add(GetAppVersion()),
          ),
          BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        ],
        child: Scores2GoApp(),
      ),
    ),
  );
}

class Scores2GoApp extends StatelessWidget {
  const Scores2GoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scoresRepo = context.read<ScoresRepository>();

    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, settingsState) {
        final lang = settingsState.locale?.languageCode ?? 'de';
        context.read<ScoresRepository>().setLocale(lang);
      },
      builder: (settingsContext, settingsState) => MaterialApp(
        title: 'Scores2Go',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('de')],
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        locale: settingsState.locale,
        themeMode: settingsState.useSystemTheme
            ? ThemeMode.system
            : (settingsState.isDarkMode ? ThemeMode.dark : ThemeMode.light),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (authContext, authState) {
            if (authState.status == AuthStatus.passwordRecovery) {
              return const ResetPasswordScreen();
            }

            // Score browsing needs no account, so HomeScreen is the root for
            // both anonymous and authenticated sessions. HomeBloc and
            // RecentlyUsedBloc aren't user-scoped, so they're created once
            // and survive sign-in/sign-out (no reason to reset nav state).
            // UserFavoritesBloc/CollectionsBloc hold per-account data, so
            // they're keyed on auth status: the key change forces a clean
            // recreate on every anon<->authenticated transition, avoiding
            // stale data from a previous session leaking into a new one.
            final isAuthenticated = authState.isAuthenticated;
            return MultiBlocProvider(
              providers: [
                BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
                BlocProvider<RecentlyUsedBloc>(
                  create: (context) =>
                      RecentlyUsedBloc(scoresRepo)
                        ..add(LoadRecentlyUsedEvent()),
                ),
              ],
              child: MultiBlocProvider(
                key: ValueKey(isAuthenticated),
                providers: [
                  BlocProvider<UserFavoritesBloc>(
                    create: (context) {
                      final bloc = UserFavoritesBloc(scoresRepo);
                      if (isAuthenticated) {
                        bloc.add(const LoadUserFavoritesEvent());
                      }
                      return bloc;
                    },
                  ),
                  BlocProvider<CollectionsBloc>(
                    create: (context) {
                      final bloc = CollectionsBloc(
                        context.read<CollectionsRepository>(),
                      );
                      if (isAuthenticated) {
                        bloc.add(const LoadCollectionsEvent());
                      }
                      return bloc;
                    },
                  ),
                ],
                child: HomeScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/collections/bloc/collections_bloc.dart';
import 'package:scores_2_go/home/bloc/home_bloc.dart';
import 'package:scores_2_go/recently_used/bloc/recently_used_bloc.dart';
import 'package:scores_2_go/user_favorites/bloc/user_favorites_bloc.dart';

/// Re-provides the HomeScreen-level blocs to [child].
///
/// These blocs live inside `MaterialApp.home`, i.e. below the Navigator, so
/// pushed routes and dialogs can't see them. Wrap the content of any route or
/// dialog that needs them (or that may call `openScoreEntry`) with this.
/// [context] must be below the blocs.
Widget provideHomeBlocs(BuildContext context, Widget child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider.value(value: context.read<HomeBloc>()),
      BlocProvider.value(value: context.read<RecentlyUsedBloc>()),
      BlocProvider.value(value: context.read<UserFavoritesBloc>()),
      BlocProvider.value(value: context.read<CollectionsBloc>()),
    ],
    child: child,
  );
}

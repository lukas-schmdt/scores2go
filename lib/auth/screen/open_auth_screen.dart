import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/auth/bloc/auth_bloc.dart';
import 'package:scores_2_go/auth/screen/auth_screen.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';

/// Pushes the sign-in / register flow as a route. `AuthScreen` pops itself
/// once the user successfully signs in (see its `BlocConsumer` listener).
void openAuthScreen(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: context.read<AuthBloc>(),
        child: const AuthScreen(),
      ),
    ),
  );
}

/// Guards an action that requires a signed-in session. Returns `true` if
/// already signed in. Otherwise shows a snackbar explaining why, with a
/// "Sign in" action that opens [openAuthScreen], and returns `false`.
bool ensureSignedIn(BuildContext context, {required String message}) {
  if (context.read<AuthBloc>().state.isAuthenticated) return true;

  final l = AppLocalizations.of(context)!;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      action: SnackBarAction(label: l.login, onPressed: () => openAuthScreen(context)),
    ),
  );
  return false;
}

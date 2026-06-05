import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/auth/bloc/auth_bloc.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/settings/screen/disclaimer_screen.dart';
import 'package:scores_2_go/settings/screen/settings_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return NavigationDrawer(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Text(
            l.appTitle,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: Text(l.drawerHome),
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: Text(l.settings),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsScreen()),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.info),
          title: Text(l.drawerAbout),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DisclaimerScreen()),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: Text(l.logout),
          onTap: () => context.read<AuthBloc>().add(LogoutEvent()),
        ),
      ],
    );
  }
}

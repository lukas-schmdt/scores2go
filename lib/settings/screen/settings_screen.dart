import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/auth/bloc/auth_bloc.dart';
import 'package:scores_2_go/settings/bloc/settings_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Einstellungen')),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                children: [
                  // ── Konto ──────────────────────────────────────────────────
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: Text(
                            'Konto',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const ListTile(
                          title: Text('E-Mail'),
                          subtitle: Text('info@score2go.dev'),
                          trailing: Icon(Icons.edit),
                        ),
                        const ListTile(
                          title: Text('Passwort'),
                          subtitle: Text('**********'),
                          trailing: Icon(Icons.edit),
                        ),
                        ListTile(
                          title: Text(
                            'Abmelden',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          leading: Icon(
                            Icons.logout,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          onTap: () => context
                              .read<AuthBloc>()
                              .add(const LogoutEvent()),
                        ),
                      ],
                    ),
                  ),
                  // ── App ────────────────────────────────────────────────────
                  Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: Text(
                            'App',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          title: const Text('Dunkelmodus'),
                          trailing: Switch(
                            value: state.isDarkMode,
                            onChanged: (_) => context
                                .read<SettingsBloc>()
                                .add(const ToggleDarkModeEvent()),
                          ),
                        ),
                        ListTile(
                          title: const Text('App-Name'),
                          trailing: Text(state.appName),
                        ),
                        ListTile(
                          title: const Text('Paketname'),
                          trailing: Text(state.packageName),
                        ),
                        ListTile(
                          title: const Text('Version'),
                          trailing: Text(state.appVersion),
                        ),
                        ListTile(
                          title: const Text('Build-Nummer'),
                          trailing: Text(state.buildNumber),
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
    );
  }
}

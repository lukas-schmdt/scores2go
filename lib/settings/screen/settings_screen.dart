import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/auth/bloc/auth_bloc.dart';
import 'package:scores_2_go/settings/bloc/settings_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showChangePasswordDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: context.read<AuthBloc>(),
          child: const _ChangePasswordDialog(),
        );
      },
    );
  }

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
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          title: const Text('E-Mail'),
                          subtitle: Text(
                            context.read<AuthBloc>().state.username ??
                                'Keine E-Mail-Adresse',
                          ),
                        ),
                        ListTile(
                          title: const Text('Passwort'),
                          subtitle: const Text('**********'),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _showChangePasswordDialog(context),
                          ),
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
                          onTap: () =>
                              context.read<AuthBloc>().add(const LogoutEvent()),
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
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          title: const Text('Dunkelmodus'),
                          trailing: Switch(
                            value: state.isDarkMode,
                            onChanged: (_) => context.read<SettingsBloc>().add(
                              const ToggleDarkModeEvent(),
                            ),
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

class _ChangePasswordDialog extends StatefulWidget {
  const _ChangePasswordDialog();

  @override
  State<_ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<_ChangePasswordDialog> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  String? _validationError;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    final current = _currentPasswordController.text.trim();
    final next = _newPasswordController.text;
    final confirm = _confirmPasswordController.text;

    if (current.isEmpty || next.isEmpty || confirm.isEmpty) {
      setState(() => _validationError = 'Bitte alle Felder ausfüllen.');
      return;
    }
    if (next != confirm) {
      setState(() => _validationError = 'Passwörter stimmen nicht überein.');
      return;
    }
    if (next.length < 6) {
      setState(() => _validationError = 'Mindestens 6 Zeichen erforderlich.');
      return;
    }

    setState(() => _validationError = null);
    context.read<AuthBloc>().add(ChangePasswordEvent(current, next));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.changePasswordSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Passwort erfolgreich geändert.')),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == AuthStatus.loading;

        return AlertDialog(
          title: const Text('Passwort ändern'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.status == AuthStatus.changePasswordFailed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      state.errorMessage ?? 'Fehler beim Ändern des Passworts.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                if (_validationError != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      _validationError!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                TextField(
                  controller: _currentPasswordController,
                  obscureText: _obscureCurrent,
                  decoration: InputDecoration(
                    labelText: 'Aktuelles Passwort',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureCurrent
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () =>
                          setState(() => _obscureCurrent = !_obscureCurrent),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _newPasswordController,
                  obscureText: _obscureNew,
                  decoration: InputDecoration(
                    labelText: 'Neues Passwort',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureNew ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () =>
                          setState(() => _obscureNew = !_obscureNew),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirm,
                  decoration: InputDecoration(
                    labelText: 'Passwort bestätigen',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () =>
                          setState(() => _obscureConfirm = !_obscureConfirm),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.of(context).pop(),
              child: const Text('Abbrechen'),
            ),
            FilledButton(
              onPressed: isLoading ? null : _submit,
              child: isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Speichern'),
            ),
          ],
        );
      },
    );
  }
}

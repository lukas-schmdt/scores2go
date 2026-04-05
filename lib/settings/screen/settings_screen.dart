import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/auth/bloc/auth_bloc.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
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
    final l = AppLocalizations.of(context)!;
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(l.settings)),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: Text(
                            l.account,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          title: Text(l.email),
                          subtitle: Text(
                            context.read<AuthBloc>().state.username,
                          ),
                        ),
                        ListTile(
                          title: Text(l.password),
                          subtitle: const Text('**********'),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _showChangePasswordDialog(context),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            l.logout,
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
                  Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: Text(
                            l.appSection,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          title: Text(l.darkMode),
                          trailing: Switch(
                            value: state.isDarkMode,
                            onChanged: (_) => context.read<SettingsBloc>().add(
                              const ToggleDarkModeEvent(),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(l.languageLabel),
                          trailing: _LanguageDropdown(current: state.locale),
                        ),
                        ListTile(
                          title: Text(l.appNameLabel),
                          trailing: Text(state.appName),
                        ),
                        ListTile(
                          title: Text(l.packageNameLabel),
                          trailing: Text(state.packageName),
                        ),
                        ListTile(
                          title: Text(l.versionLabel),
                          trailing: Text(state.appVersion),
                        ),
                        ListTile(
                          title: Text(l.buildNumberLabel),
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

class _LanguageDropdown extends StatelessWidget {
  const _LanguageDropdown({required this.current});
  final Locale? current;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final options = <Locale?, String>{
      null: l.languageSystem,
      const Locale('de'): l.languageDe,
      const Locale('en'): l.languageEn,
    };

    return DropdownButton<Locale?>(
      value: current,
      underline: const SizedBox.shrink(),
      items: options.entries
          .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
          .toList(),
      onChanged: (locale) =>
          context.read<SettingsBloc>().add(SetLocaleEvent(locale)),
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
    final l = AppLocalizations.of(context)!;
    final current = _currentPasswordController.text.trim();
    final next = _newPasswordController.text;
    final confirm = _confirmPasswordController.text;

    if (current.isEmpty || next.isEmpty || confirm.isEmpty) {
      setState(() => _validationError = l.fillAllFields);
      return;
    }
    if (next != confirm) {
      setState(() => _validationError = l.passwordsDoNotMatch);
      return;
    }
    if (next.length < 6) {
      setState(() => _validationError = l.minSixCharsRequired);
      return;
    }

    setState(() => _validationError = null);
    context.read<AuthBloc>().add(ChangePasswordEvent(current, next));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.changePasswordSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l.passwordChangedSuccess)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == AuthStatus.loading;

        return AlertDialog(
          title: Text(l.changePasswordTitle),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.status == AuthStatus.changePasswordFailed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      state.errorMessage ?? l.changePasswordError,
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
                    labelText: l.currentPassword,
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
                    labelText: l.newPassword,
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
                    labelText: l.confirmPassword,
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
              child: Text(l.cancel),
            ),
            FilledButton(
              onPressed: isLoading ? null : _submit,
              child: isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l.save),
            ),
          ],
        );
      },
    );
  }
}

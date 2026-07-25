import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scores_2_go/auth/bloc/auth_bloc.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/settings/bloc/settings_bloc.dart';
import 'package:scores_2_go/settings/screen/disclaimer_screen.dart';
import 'package:scores_2_go/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showChangePasswordDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<AuthBloc>(),
        child: const _ChangePasswordDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {},
      builder: (context, state) {
        final effectiveDark = Theme.of(context).brightness == Brightness.dark;
        return Scaffold(
          appBar: AppBar(title: Text(l.settings)),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Account section
                _SectionHeader(l.account),
                _SettingsCard(
                  children: [
                    _InfoTile(
                      icon: Icons.email_outlined,
                      label: l.email,
                      value: context.read<AuthBloc>().state.username,
                    ),
                    _Divider(),
                    _ActionTile(
                      icon: Icons.lock_outline,
                      label: l.password,
                      value: '••••••••',
                      onTap: () => _showChangePasswordDialog(context),
                    ),
                    _Divider(),
                    _ActionTile(
                      icon: Icons.logout,
                      label: l.logout,
                      iconColor: cs.error,
                      labelColor: cs.error,
                      onTap: () =>
                          context.read<AuthBloc>().add(const LogoutEvent()),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Appearance section
                _SectionHeader(l.appearance),
                _SettingsCard(
                  children: [
                    _SwitchTile(
                      icon: effectiveDark
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                      label: l.darkMode,
                      value: effectiveDark,
                      onChanged: (_) => context.read<SettingsBloc>().add(
                            ToggleDarkModeEvent(currentIsDark: effectiveDark),
                          ),
                    ),
                    _Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          Icon(Icons.language_outlined,
                              size: 20, color: cs.onSurfaceVariant),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              l.languageLabel,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          _LanguageDropdown(current: state.locale),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // About section
                _SectionHeader(l.appSection),
                _SettingsCard(
                  children: [
                    _InfoTile(
                        icon: Icons.apps,
                        label: l.appNameLabel,
                        value: state.appName),
                    _Divider(),
                    _InfoTile(
                        icon: Icons.tag,
                        label: l.versionLabel,
                        value: state.appVersion),
                    _Divider(),
                    _InfoTile(
                        icon: Icons.build_outlined,
                        label: l.buildNumberLabel,
                        value: state.buildNumber),
                    _Divider(),
                    _ActionTile(
                      icon: Icons.info_outline,
                      label: l.disclaimerTitle,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DisclaimerScreen(),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Buy me a coffee
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: Material(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.transparent,
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.blue, AppColors.teal],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => url_launcher.launchUrl(
                          Uri.parse(
                              'https://www.buymeacoffee.com/lukas.schmdt'),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 22,
                              height: 22,
                              child: SvgPicture.asset('assets/bmc-logo.svg'),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              l.buyMeACoffee,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Shared helpers ─────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      indent: 48,
      color: Theme.of(context).colorScheme.outline,
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 20, color: cs.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: tt.bodyLarge)),
          Text(value, style: tt.bodyMedium),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    this.value,
    this.iconColor,
    this.labelColor,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final String? value;
  final Color? iconColor;
  final Color? labelColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 20, color: iconColor ?? cs.onSurfaceVariant),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: tt.bodyLarge?.copyWith(color: labelColor),
              ),
            ),
            if (value != null)
              Text(value!, style: tt.bodyMedium),
            if (value != null) const SizedBox(width: 4),
            Icon(Icons.chevron_right,
                size: 18, color: iconColor ?? cs.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: cs.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: tt.bodyLarge)),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

// ── Language dropdown ──────────────────────────────────────────────────────────

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

// ── Change password dialog ─────────────────────────────────────────────────────

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
        final cs = Theme.of(context).colorScheme;

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
                      style: TextStyle(color: cs.error),
                    ),
                  ),
                if (_validationError != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      _validationError!,
                      style: TextStyle(color: cs.error),
                    ),
                  ),
                TextField(
                  controller: _currentPasswordController,
                  obscureText: _obscureCurrent,
                  decoration: InputDecoration(
                    labelText: l.currentPassword,
                    suffixIcon: IconButton(
                      icon: Icon(_obscureCurrent
                          ? Icons.visibility
                          : Icons.visibility_off),
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
                      icon: Icon(_obscureNew
                          ? Icons.visibility
                          : Icons.visibility_off),
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
                      icon: Icon(_obscureConfirm
                          ? Icons.visibility
                          : Icons.visibility_off),
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

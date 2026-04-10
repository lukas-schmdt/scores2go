import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scores_2_go/auth/bloc/auth_bloc.dart';
import 'package:scores_2_go/auth/screen/forgot_password_screen.dart';
import 'package:scores_2_go/auth/screen/register_screen.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/settings/bloc/settings_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _obscurePassword = true;

  void _submit(BuildContext context, AuthState state) {
    context.read<AuthBloc>().add(LoginEvent(state.username, state.password));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settings) {
        final isDark = settings.isDarkMode;
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final loading = state.status == AuthStatus.loading;

            return Scaffold(
              backgroundColor: isDark
                  ? const Color(0xFF02122B)
                  : const Color(0xFFF0F6FF),
              body: SafeArea(
                child: Stack(
                  children: [
                    Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 48,
                        ),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 420),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _BrandingHeader(cs: cs, isDark: isDark),
                              const SizedBox(height: 40),

                              if (state.status == AuthStatus.registerSuccess) ...[
                                _SuccessBanner(
                                  message: l.emailCheckTitle,
                                  subtitle: l.emailCheckSubtitle,
                                ),
                                const SizedBox(height: 16),
                              ],
                              if (state.status == AuthStatus.resetPasswordSuccess) ...[
                                _SuccessBanner(message: l.passwordResetSuccess),
                                const SizedBox(height: 16),
                              ],

                              Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(color: cs.outlineVariant),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      TextFormField(
                                        initialValue: state.username,
                                        onChanged: (v) => context
                                            .read<AuthBloc>()
                                            .add(EmailChangedEvent(v)),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        autofillHints: const [
                                          AutofillHints.email,
                                        ],
                                        decoration: InputDecoration(
                                          labelText: l.emailLabel,
                                          prefixIcon: const Icon(
                                            Icons.email_outlined,
                                          ),
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      TextFormField(
                                        initialValue: state.password,
                                        onChanged: (v) => context
                                            .read<AuthBloc>()
                                            .add(PasswordChangedEvent(v)),
                                        obscureText: _obscurePassword,
                                        textInputAction: TextInputAction.done,
                                        autofillHints: const [
                                          AutofillHints.password,
                                        ],
                                        onFieldSubmitted: (_) =>
                                            _submit(context, state),
                                        decoration: InputDecoration(
                                          labelText: l.passwordLabel,
                                          prefixIcon: const Icon(
                                            Icons.lock_outline,
                                          ),
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscurePassword
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                            ),
                                            onPressed: () => setState(
                                              () => _obscurePassword =
                                                  !_obscurePassword,
                                            ),
                                          ),
                                        ),
                                      ),

                                      if (state.status ==
                                          AuthStatus.loginFailed) ...[
                                        const SizedBox(height: 16),
                                        _ErrorBanner(
                                          message: state.errorMessage ??
                                              l.loginFailed,
                                        ),
                                      ],

                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4,
                                            ),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  BlocProvider.value(
                                                value: context.read<AuthBloc>(),
                                                child:
                                                    const ForgotPasswordScreen(),
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            l.forgotPassword,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: cs.primary,
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 12),

                                      FilledButton(
                                        onPressed: loading
                                            ? null
                                            : () => _submit(context, state),
                                        style: FilledButton.styleFrom(
                                          minimumSize:
                                              const Size.fromHeight(48),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          backgroundColor:
                                              _BrandingHeader._gradientStart,
                                          foregroundColor: Colors.white,
                                          disabledBackgroundColor:
                                              _BrandingHeader._gradientStart
                                                  .withValues(alpha: 0.5),
                                        ),
                                        child: loading
                                            ? SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: cs.onPrimary,
                                                ),
                                              )
                                            : Text(
                                                l.login,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),
                              TextButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                      value: context.read<AuthBloc>(),
                                      child: const RegisterScreen(),
                                    ),
                                  ),
                                ),
                                child: Text(l.noAccountRegister),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Theme toggle in top-right corner
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: Icon(
                          isDark
                              ? Icons.light_mode_outlined
                              : Icons.dark_mode_outlined,
                          color: isDark
                              ? Colors.white54
                              : const Color(0xFF0176E4),
                        ),
                        onPressed: () => context
                            .read<SettingsBloc>()
                            .add(const ToggleDarkModeEvent()),
                        tooltip: isDark ? 'Light mode' : 'Dark mode',
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _BrandingHeader extends StatelessWidget {
  const _BrandingHeader({required this.cs, required this.isDark});
  final ColorScheme cs;
  final bool isDark;

  static const _gradientStart = Color(0xFF0176E4);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: _gradientStart.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: SvgPicture.asset(
              'assets/app_icon.svg',
              width: 88,
              height: 88,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),

        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                text: 'Scores',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : cs.onSurface,
                ),
              ),
              TextSpan(
                text: '2',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0ED0BD),
                ),
              ),
              TextSpan(
                text: 'Go',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? const Color(0xFF027BE4) : _gradientStart,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l.appSubtitle,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _SuccessBanner extends StatelessWidget {
  const _SuccessBanner({required this.message, this.subtitle});
  final String message;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline, size: 16, color: cs.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    color: cs.onPrimaryContainer,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: cs.onPrimaryContainer,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cs.errorContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, size: 16, color: cs.onErrorContainer),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: cs.onErrorContainer, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scores_2_go/auth/bloc/auth_bloc.dart';
import 'package:scores_2_go/auth/screen/forgot_password_screen.dart';
import 'package:scores_2_go/auth/screen/register_screen.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/settings/bloc/settings_bloc.dart';

const _navy = Color(0xFF02122B);
const _blue = Color(0xFF0176E4);
const _teal = Color(0xFF0DBBBA);

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
    final l = AppLocalizations.of(context)!;

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settings) {
        final isDark = settings.isDarkMode;
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final loading = state.status == AuthStatus.loading;

            return Scaffold(
              backgroundColor: isDark ? _navy : const Color(0xFFF0F6FF),
              body: SafeArea(
                child: Stack(
                  children: [
                    // Gradient glow behind logo area
                    if (isDark)
                      Positioned(
                        top: -80,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            width: 360,
                            height: 360,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Color(0x330176E4),
                                  Color(0x000176E4),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

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
                              _BrandingHeader(isDark: isDark),
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

                              // Login card
                              Container(
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.05)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isDark
                                        ? Colors.white.withValues(alpha: 0.1)
                                        : Colors.black.withValues(alpha: 0.07),
                                  ),
                                  boxShadow: isDark
                                      ? null
                                      : [
                                          BoxShadow(
                                            color: _blue.withValues(alpha: 0.08),
                                            blurRadius: 24,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                ),
                                padding: const EdgeInsets.all(24),
                                child: AutofillGroup(
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
                                          AutofillHints.username,
                                        ],
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                        decoration: _fieldDecoration(
                                          label: l.emailLabel,
                                          icon: Icons.email_outlined,
                                          isDark: isDark,
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
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                        decoration: _fieldDecoration(
                                          label: l.passwordLabel,
                                          icon: Icons.lock_outline,
                                          isDark: isDark,
                                          suffix: IconButton(
                                            icon: Icon(
                                              _obscurePassword
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                        .visibility_off_outlined,
                                              color: isDark
                                                  ? Colors.white38
                                                  : Colors.black38,
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
                                            padding:
                                                const EdgeInsets.symmetric(
                                                  vertical: 4,
                                                ),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            foregroundColor: _teal,
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
                                            style: const TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 12),

                                      // Gradient login button
                                      SizedBox(
                                        width: double.infinity,
                                        height: 48,
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.transparent,
                                          child: Ink(
                                            decoration: BoxDecoration(
                                              gradient: loading
                                                  ? null
                                                  : const LinearGradient(
                                                      colors: [_blue, _teal],
                                                    ),
                                              color: loading
                                                  ? _blue.withValues(alpha: 0.4)
                                                  : null,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: InkWell(
                                              onTap: loading
                                                  ? null
                                                  : () {
                                                      TextInput
                                                          .finishAutofillContext();
                                                      _submit(context, state);
                                                    },
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Center(
                                                child: loading
                                                    ? const SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child:
                                                            CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    : Text(
                                                        l.login,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                              ),
                                            ),
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
                                style: TextButton.styleFrom(
                                  foregroundColor: isDark ? _teal : _blue,
                                ),
                                child: Text(l.noAccountRegister),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Theme toggle
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: Icon(
                          isDark
                              ? Icons.light_mode_outlined
                              : Icons.dark_mode_outlined,
                          color: isDark
                              ? Colors.white38
                              : Colors.black38,
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

  InputDecoration _fieldDecoration({
    required String label,
    required IconData icon,
    required bool isDark,
    Widget? suffix,
  }) {
    final borderColor =
        isDark ? Colors.white.withValues(alpha: 0.15) : Colors.black12;
    final focusedColor = isDark ? _teal : _blue;
    final iconColor = isDark ? Colors.white38 : Colors.black38;

    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: isDark ? Colors.white54 : Colors.black45,
      ),
      prefixIcon: Icon(icon, color: iconColor),
      suffixIcon: suffix,
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: focusedColor, width: 1.5),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      filled: isDark,
      fillColor: isDark ? Colors.white.withValues(alpha: 0.04) : null,
    );
  }
}

class _BrandingHeader extends StatelessWidget {
  const _BrandingHeader({required this.isDark});
  final bool isDark;

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
                color: _blue.withValues(alpha: 0.45),
                blurRadius: 24,
                offset: const Offset(0, 8),
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
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              TextSpan(
                text: '2',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _teal,
                ),
              ),
              TextSpan(
                text: 'Go',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _blue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l.appSubtitle,
          style: TextStyle(
            fontSize: 13,
            color: isDark
                ? Colors.white.withValues(alpha: 0.45)
                : Colors.black45,
          ),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _teal.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _teal.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, size: 16, color: _teal),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: const TextStyle(
                    color: _teal,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: _teal.withValues(alpha: 0.8),
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

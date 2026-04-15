import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/auth/bloc/auth_bloc.dart';
import 'package:scores_2_go/auth/screen/forgot_password_screen.dart';
import 'package:scores_2_go/auth/widget/auth_error_banner.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/theme/app_colors.dart';

class AuthLoginCard extends StatefulWidget {
  const AuthLoginCard({
    super.key,
    required this.isDark,
    required this.authState,
  });

  final bool isDark;
  final AuthState authState;

  @override
  State<AuthLoginCard> createState() => _AuthLoginCardState();
}

class _AuthLoginCardState extends State<AuthLoginCard> {
  bool _obscurePassword = true;

  void _submit() {
    TextInput.finishAutofillContext();
    context.read<AuthBloc>().add(
          LoginEvent(widget.authState.username, widget.authState.password),
        );
  }

  InputDecoration _fieldDecoration({
    required String label,
    required IconData icon,
    Widget? suffix,
  }) {
    final isDark = widget.isDark;
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black45),
      prefixIcon: Icon(icon, color: isDark ? Colors.white38 : Colors.black38),
      suffixIcon: suffix,
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
          color: isDark ? Colors.white.withValues(alpha: 0.15) : Colors.black12,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
          color: isDark ? AppColors.teal : AppColors.blue,
          width: 1.5,
        ),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      filled: isDark,
      fillColor: isDark ? Colors.white.withValues(alpha: 0.04) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final isDark = widget.isDark;
    final state = widget.authState;
    final loading = state.status == AuthStatus.loading;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
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
                  color: AppColors.blue.withValues(alpha: 0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      padding: const EdgeInsets.all(24),
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              initialValue: state.username,
              onChanged: (v) =>
                  context.read<AuthBloc>().add(EmailChangedEvent(v)),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [
                AutofillHints.email,
                AutofillHints.username,
              ],
              style: TextStyle(color: isDark ? Colors.white : Colors.black87),
              decoration: _fieldDecoration(
                label: l.emailLabel,
                icon: Icons.email_outlined,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: state.password,
              onChanged: (v) =>
                  context.read<AuthBloc>().add(PasswordChangedEvent(v)),
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              onFieldSubmitted: (_) => _submit(),
              style: TextStyle(color: isDark ? Colors.white : Colors.black87),
              decoration: _fieldDecoration(
                label: l.passwordLabel,
                icon: Icons.lock_outline,
                suffix: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: isDark ? Colors.white38 : Colors.black38,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
            ),
            if (state.status == AuthStatus.loginFailed) ...[
              const SizedBox(height: 16),
              AuthErrorBanner(message: state.errorMessage ?? l.loginFailed),
            ],
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  foregroundColor: AppColors.teal,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<AuthBloc>(),
                      child: const ForgotPasswordScreen(),
                    ),
                  ),
                ),
                child: Text(
                  l.forgotPassword,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: Material(
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: loading
                        ? null
                        : const LinearGradient(
                            colors: [AppColors.blue, AppColors.teal],
                          ),
                    color: loading
                        ? AppColors.blue.withValues(alpha: 0.4)
                        : null,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: loading ? null : _submit,
                    borderRadius: BorderRadius.circular(12),
                    child: Center(
                      child: loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              l.login,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/auth/bloc/auth_bloc.dart';
import 'package:scores_2_go/auth/screen/register_screen.dart';
import 'package:scores_2_go/auth/widget/auth_branding_header.dart';
import 'package:scores_2_go/auth/widget/auth_login_card.dart';
import 'package:scores_2_go/auth/widget/auth_success_banner.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/theme/app_colors.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isAuthenticated) Navigator.of(context).maybePop();
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
          body: SafeArea(
            child: Stack(
              children: [
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
                            colors: [Color(0x330176E4), Color(0x000176E4)],
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
                          AuthBrandingHeader(isDark: isDark),
                          const SizedBox(height: 40),
                          if (state.status == AuthStatus.registerSuccess) ...[
                            AuthSuccessBanner(
                              message: l.emailCheckTitle,
                              subtitle: l.emailCheckSubtitle,
                            ),
                            const SizedBox(height: 16),
                          ],
                          if (state.status == AuthStatus.resetPasswordSuccess) ...[
                            AuthSuccessBanner(message: l.passwordResetSuccess),
                            const SizedBox(height: 16),
                          ],
                          AuthLoginCard(isDark: isDark, authState: state),
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
                              foregroundColor:
                                  isDark ? AppColors.teal : AppColors.blue,
                            ),
                            child: Text(l.noAccountRegister),
                          ),
                        ],
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

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scores_2_go/deep_link/deep_link_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  StreamSubscription? _supabaseSubscription;

  AuthBloc() : super(const AuthState()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<ResetPasswordEvent>(_onResetPassword);
    on<ChangePasswordEvent>(_onChangePassword);
    on<LogoutEvent>(_onLogout);
    on<EmailChangedEvent>(_onEmailChanged);
    on<PasswordChangedEvent>(_onPasswordChanged);
    on<_SupabaseAuthChangedEvent>(_onSupabaseAuthChanged);
    on<_RecoveryLinkOpenedEvent>(_onRecoveryLinkOpened);
    on<_AuthCallbackFailedEvent>(_onAuthCallbackFailed);

    _supabaseSubscription = Supabase.instance.client.auth.onAuthStateChange
        .listen(
          (data) {
            if (!isClosed) {
              add(_SupabaseAuthChangedEvent(data.event, data.session));
            }
          },
          // supabase_flutter swallows a failed `?code=` exchange from the
          // launch URL (missing code verifier, expired or reused link) and
          // only reports it here. Other errors on this stream (e.g. a failed
          // token refresh) aren't the user's concern, so only the first
          // error after an auth-callback launch is surfaced.
          onError: (Object _) {
            if (!isClosed && DeepLinkService.consumeAuthCallback()) {
              add(const _AuthCallbackFailedEvent());
            }
          },
        );

    final recoveryTokenHash = DeepLinkService.consumeRecoveryTokenHash();
    if (recoveryTokenHash != null) {
      add(_RecoveryLinkOpenedEvent(recoveryTokenHash));
    }
  }

  @override
  Future<void> close() {
    _supabaseSubscription?.cancel();
    return super.close();
  }

  void _onSupabaseAuthChanged(
    _SupabaseAuthChangedEvent event,
    Emitter<AuthState> emit,
  ) {
    switch (event.changeEvent) {
      case AuthChangeEvent.initialSession:
        // Restore session on app start if one exists.
        if (event.session != null) {
          emit(
            state.copyWith(
              status: AuthStatus.authenticated,
              username: event.session!.user.email ?? '',
              token: event.session!.accessToken,
              refreshToken: event.session!.refreshToken ?? '',
              clearError: true,
            ),
          );
        }
      case AuthChangeEvent.passwordRecovery:
        emit(
          state.copyWith(
            status: AuthStatus.passwordRecovery,
            inPasswordRecovery: true,
            clearError: true,
          ),
        );
      case AuthChangeEvent.tokenRefreshed:
        if (event.session != null) {
          emit(
            state.copyWith(
              token: event.session!.accessToken,
              refreshToken: event.session!.refreshToken ?? '',
            ),
          );
        }
      default:
        break;
    }
  }

  /// Verifies a `?token_hash=…&type=recovery` reset link. Unlike the PKCE
  /// `?code=` flow this needs no code verifier, so the link works in any
  /// browser. On success gotrue emits [AuthChangeEvent.passwordRecovery],
  /// handled in [_onSupabaseAuthChanged].
  Future<void> _onRecoveryLinkOpened(
    _RecoveryLinkOpenedEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await Supabase.instance.client.auth.verifyOTP(
        tokenHash: event.tokenHash,
        type: OtpType.recovery,
      );
    } catch (_) {
      _emitAuthLinkInvalid(emit);
    }
  }

  void _onAuthCallbackFailed(
    _AuthCallbackFailedEvent event,
    Emitter<AuthState> emit,
  ) {
    _emitAuthLinkInvalid(emit);
  }

  void _emitAuthLinkInvalid(Emitter<AuthState> emit) {
    emit(state.copyWith(status: AuthStatus.authLinkInvalid, clearError: true));
    // A bad link doesn't end an existing session; restore the signed-in
    // status so the rest of the app doesn't treat the user as signed out.
    final session = Supabase.instance.client.auth.currentSession;
    if (session != null) {
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          username: session.user.email ?? '',
          token: session.accessToken,
          refreshToken: session.refreshToken ?? '',
        ),
      );
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    if (event.username.isEmpty || event.password.isEmpty) {
      emit(state.copyWith(status: AuthStatus.loginFailed, clearError: true));
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading, clearError: true));

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: event.username,
        password: event.password,
      );
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          username: event.username,
          password: '',
          token: response.session?.accessToken ?? '',
          refreshToken: response.session?.refreshToken ?? '',
          clearError: true,
        ),
      );
    } on AuthException catch (e) {
      emit(
        state.copyWith(status: AuthStatus.loginFailed, errorMessage: e.message),
      );
    } catch (_) {
      emit(state.copyWith(status: AuthStatus.loginFailed, clearError: true));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading, clearError: true));

    try {
      await Supabase.instance.client.auth.signUp(
        email: event.email,
        password: event.password,
        emailRedirectTo: kIsWeb
            ? 'https://scores2go.com/app/'
            : 'io.supabase.scores2go://login-callback',
      );
      emit(
        state.copyWith(
          status: AuthStatus.registerSuccess,
          username: event.email,
          password: '',
          clearError: true,
        ),
      );
    } on AuthException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.registerFailed,
          errorMessage: e.message,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: AuthStatus.registerFailed, clearError: true));
    }
  }

  Future<void> _onForgotPassword(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, clearError: true));

    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(
        event.email,
        // The reset is always completed in the web app, also when requested
        // from a native app: the "Reset Password" email template links to
        // `{{ .RedirectTo }}?token_hash=…&type=recovery`, which the web app
        // verifies on startup (see DeepLinkService). Custom-scheme links are
        // unreliable in mail clients.
        redirectTo: 'https://scores2go.com/app/',
      );
      emit(
        state.copyWith(status: AuthStatus.forgotPasswordSent, clearError: true),
      );
    } on AuthException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.forgotPasswordFailed,
          errorMessage: e.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: AuthStatus.forgotPasswordFailed,
          clearError: true,
        ),
      );
    }
  }

  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, clearError: true));

    try {
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: event.newPassword),
      );
      await Supabase.instance.client.auth.signOut();
      emit(
        state.copyWith(
          status: AuthStatus.resetPasswordSuccess,
          password: '',
          token: '',
          refreshToken: '',
          clearError: true,
          inPasswordRecovery: false,
        ),
      );
    } on AuthException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.resetPasswordFailed,
          errorMessage: e.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: AuthStatus.resetPasswordFailed,
          clearError: true,
        ),
      );
    }
  }

  Future<void> _onChangePassword(
    ChangePasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, clearError: true));

    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: state.username,
        password: event.currentPassword,
      );
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: event.newPassword),
      );
      emit(
        state.copyWith(
          status: AuthStatus.changePasswordSuccess,
          clearError: true,
        ),
      );
    } on AuthException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.changePasswordFailed,
          errorMessage: e.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: AuthStatus.changePasswordFailed,
          clearError: true,
        ),
      );
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await Supabase.instance.client.auth.signOut();
    emit(const AuthState());
  }

  void _onEmailChanged(EmailChangedEvent event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        username: event.email,
        status: AuthStatus.initial,
        clearError: true,
      ),
    );
  }

  void _onPasswordChanged(PasswordChangedEvent event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        password: event.password,
        status: AuthStatus.initial,
        clearError: true,
      ),
    );
  }
}

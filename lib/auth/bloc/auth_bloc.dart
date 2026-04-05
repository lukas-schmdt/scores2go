import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
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

    _supabaseSubscription = Supabase.instance.client.auth.onAuthStateChange
        .listen((data) {
          if (!isClosed) {
            add(_SupabaseAuthChangedEvent(data.event, data.session));
          }
        });
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
          state.copyWith(status: AuthStatus.passwordRecovery, clearError: true),
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
            ? 'https://lukas-schmdt.github.io/scores2go/'
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
        redirectTo: kIsWeb
            ? 'https://lukas-schmdt.github.io/scores2go/'
            : 'io.supabase.scores2go://login-callback',
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
      emit(state.copyWith(status: AuthStatus.changePasswordSuccess, clearError: true));
    } on AuthException catch (e) {
      emit(state.copyWith(status: AuthStatus.changePasswordFailed, errorMessage: e.message));
    } catch (_) {
      emit(state.copyWith(status: AuthStatus.changePasswordFailed, clearError: true));
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

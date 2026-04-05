part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  loginFailed,
  registerSuccess,
  registerFailed,
  forgotPasswordSent,
  forgotPasswordFailed,
  passwordRecovery,
  resetPasswordFailed,
  resetPasswordSuccess,
}

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.username = '',
    this.password = '',
    this.token = '',
    this.refreshToken = '',
    this.errorMessage,
  });

  final AuthStatus status;
  final String username;
  final String password;
  final String token;
  final String refreshToken;
  final String? errorMessage;

  AuthState copyWith({
    AuthStatus? status,
    String? username,
    String? password,
    String? token,
    String? refreshToken,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props =>
      [status, username, password, token, refreshToken, errorMessage];
}

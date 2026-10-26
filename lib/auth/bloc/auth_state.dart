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
  changePasswordSuccess,
  changePasswordFailed,
  authLinkInvalid,
}

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.username = '',
    this.password = '',
    this.token = '',
    this.refreshToken = '',
    this.errorMessage,
    this.inPasswordRecovery = false,
  });

  final AuthStatus status;
  final String username;
  final String password;
  final String token;
  final String refreshToken;
  final String? errorMessage;

  /// Whether a password-reset link was opened and the new password hasn't
  /// been saved yet. `status == AuthStatus.passwordRecovery` alone isn't
  /// enough: submitting the new password moves `status` to `loading` and
  /// then possibly `resetPasswordFailed`, and the reset screen must stay up
  /// through both.
  final bool inPasswordRecovery;

  AuthState copyWith({
    AuthStatus? status,
    String? username,
    String? password,
    String? token,
    String? refreshToken,
    String? errorMessage,
    bool clearError = false,
    bool? inPasswordRecovery,
  }) {
    return AuthState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      inPasswordRecovery: inPasswordRecovery ?? this.inPasswordRecovery,
    );
  }

  /// Whether this state represents a signed-in session. `status ==
  /// AuthStatus.authenticated` alone isn't enough: changing the password
  /// (see `_onChangePassword` in AuthBloc) leaves the user signed in but
  /// moves `status` to `changePasswordSuccess`/`changePasswordFailed`
  /// without ever re-emitting `authenticated`.
  bool get isAuthenticated =>
      status == AuthStatus.authenticated ||
      status == AuthStatus.changePasswordSuccess ||
      status == AuthStatus.changePasswordFailed;

  @override
  List<Object?> get props => [
    status,
    username,
    password,
    token,
    refreshToken,
    errorMessage,
    inPasswordRecovery,
  ];
}

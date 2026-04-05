part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  const LoginEvent(this.username, this.password);

  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];
}

class RegisterEvent extends AuthEvent {
  const RegisterEvent(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class ForgotPasswordEvent extends AuthEvent {
  const ForgotPasswordEvent(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class ResetPasswordEvent extends AuthEvent {
  const ResetPasswordEvent(this.newPassword);

  final String newPassword;

  @override
  List<Object> get props => [newPassword];
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

class EmailChangedEvent extends AuthEvent {
  const EmailChangedEvent(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordChangedEvent extends AuthEvent {
  const PasswordChangedEvent(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class _SupabaseAuthChangedEvent extends AuthEvent {
  const _SupabaseAuthChangedEvent(this.changeEvent, this.session);

  final AuthChangeEvent changeEvent;
  final Session? session;

  @override
  List<Object> get props => [changeEvent];
}

import '../../../domain/entities/auth.dart';

abstract class AuthState {}

class AuthSuccess extends AuthState {
  final Auth? auth;
  AuthSuccess(this.auth);
}

class AuthStart implements AuthState {
  const AuthStart();
}

class AuthLoading implements AuthState {
  const AuthLoading();
}

class AuthError implements AuthState {
  final Exception error;
  AuthError(this.error);
}

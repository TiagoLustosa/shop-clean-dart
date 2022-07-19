import '../../../domain/entities/auth_credentials.dart';

abstract class AuthEvent {}

class AuthWithEmailSend extends AuthEvent {
  final AuthCredentials credentials;

  AuthWithEmailSend(this.credentials);
}

abstract class AuthEvent {}

class AuthWithEmailSend extends AuthEvent {
  final String email;
  final String password;

  AuthWithEmailSend(this.email, this.password);
}

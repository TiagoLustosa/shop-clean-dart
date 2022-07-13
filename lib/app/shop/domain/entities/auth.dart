import 'dart:async';

class Auth {
  final String? token;
  final String? userId;
  final String? email;
  final DateTime? expiryDate;
  final Timer? logoutTimer;

  Auth({
    this.token,
    this.userId,
    this.email,
    this.expiryDate,
    this.logoutTimer,
  });
}

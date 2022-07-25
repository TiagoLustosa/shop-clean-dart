import 'dart:async';
import 'dart:convert';
import 'dart:core';

import '../../domain/entities/auth.dart';

class AuthResultModel extends Auth {
  final String? token;
  final String? userId;
  final String? email;
  // final DateTime? expiryDate;
  // final Timer? logoutTimer;

  AuthResultModel({
    this.token,
    this.userId,
    this.email,
    //  this.expiryDate,
    //  this.logoutTimer,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'userId': userId,
      'email': email,
      'expiryDate': expiryDate,
      'logoutTimer': logoutTimer,
    };
  }

  static AuthResultModel fromMap(Map<String, dynamic> map) {
    return AuthResultModel(
      token: map['idToken'],
      userId: map['localId'],
      email: map['email'],
      //   expiryDate:
      //      DateTime.now().add(Duration(seconds: int.parse(map['expiresIn']))),
      //   logoutTimer: map['logoutTimer'],
    );
  }

  String toJson() => jsonEncode(toMap());

  static AuthResultModel fromJson(String source) => fromMap(jsonDecode(source));
}

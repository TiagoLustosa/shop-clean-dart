import 'dart:async';
import 'dart:convert';
import 'dart:core';

import '../../domain/entities/auth.dart';

class AuthResultModel extends Auth {
  final String? idToken;
  final String? localId;
  final String? email;
  final DateTime? expiryDate;
  final Timer? logoutTimer;

  AuthResultModel({
    this.idToken,
    this.localId,
    this.email,
    this.expiryDate,
    this.logoutTimer,
  });
  factory AuthResultModel.fromJson(Map<String, dynamic> json) {
    return AuthResultModel(
      idToken: json['idToken'],
      localId: json['localId'],
      email: json['email'],
      expiryDate: json['expiryDate'],
      logoutTimer: json['logoutTimer'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'idToken': idToken,
      'localId': localId,
      'email': email,
      'expiryDate': expiryDate,
      'logoutTimer': logoutTimer,
    };
  }
}

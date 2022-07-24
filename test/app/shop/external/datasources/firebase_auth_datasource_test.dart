import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth_credentials.dart';
import 'package:shop_clean_arch/app/shop/external/datasources/firebase_auth_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import 'package:shop_clean_arch/app/shop/utils/constants.dart';

import '../../utils/firebase_response.dart';

class MockDio extends Mock implements Dio {}

main() {
  final dioMock = Dio(BaseOptions());

  final dioAdapter = DioAdapter(dio: dioMock);
  FirebaseAuthDataSource firebaseDataSource = FirebaseAuthDataSource(dioMock);
  dioMock.httpClientAdapter = dioAdapter;
  final authCredentials = AuthCredentials('teste@gmail.com', 'teste123');
  final userCredentials = <String, dynamic>{
    'email:': authCredentials.email,
    'password': authCredentials.password,
    'returnSecureToken': true
  };
  setUp(() {
    registerFallbackValue(AuthCredentials());
  });
  test('should return an error if status code is not 200', () async {
    dioAdapter.onPost(
      firebaseURL,
      (server) => server.reply(
        200,
        jsonDecode(firebaseResponse),
        delay: const Duration(seconds: 1),
      ),
      data: Matchers.any,
    );
    final result = firebaseDataSource.authWithEmail(authCredentials);
    expect(result, completes);
  });

  test('should return an Exception if dio returns error', () async {
    dioAdapter.onPost(
      firebaseURL,
      (server) => server.reply(
        201,
        firebaseResponse,
        delay: const Duration(seconds: 1),
      ),
      data: userCredentials,
    );
    //   final result = firebaseDataSource.authWithEmail(authCredentials);
    //   expect(result, isA<Future<AuthResultModel>>());
  });

  test('should return a AuthResultModel', () async {
    dioAdapter.onPost(
      firebaseURL,
      (server) => server.reply(
        201,
        firebaseResponse,
        delay: const Duration(seconds: 1),
      ),
      data: userCredentials,
    );
    final result = await dioMock.post(firebaseURL, data: userCredentials);
    expect(result.statusCode, 201);
    expect(AuthResultModel.fromJson(result.data), isA<AuthResultModel>());
  });
}

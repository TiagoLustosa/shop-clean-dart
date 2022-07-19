import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth_credentials.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/auth_exceptions.dart';
import 'package:shop_clean_arch/app/shop/external/datasources/firebase_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/dependency_injection/dependency_injection_config.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';
import 'package:shop_clean_arch/app/shop/utils/constants.dart';
import '../../utils/firebase_response.dart';

class DioMock extends Mock implements Dio {
  final BaseOptions baseOptions;
  DioMock(this.baseOptions);
}

main() {
  final dioMock = Dio(BaseOptions()); //DioMock(BaseOptions());

  final dioAdapter = DioAdapter(dio: dioMock);
  FirebaseDataSource firebaseDataSource = FirebaseDataSource(dioMock);
  dioMock.httpClientAdapter = dioAdapter;

  final authCredentials = AuthCredentials('teste@gmail.com', 'teste123');
  final userCredentials = <String, dynamic>{
    'email:': authCredentials.email,
    'password': authCredentials.password,
    'returnSecureToken': true
  };
  Response<dynamic> response;
  setUp(() {
    registerFallbackValue(AuthCredentials());
  });
  test('should return an error if status code is not 200', () async {
    dioAdapter.onPost(
      firebaseURL,
      (server) => server.reply(
        200,
        jsonDecode(firebaseResponse),
        delay: Duration(seconds: 1),
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
        delay: Duration(seconds: 1),
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
        delay: Duration(seconds: 1),
      ),
      data: userCredentials,
    );
    final result = await dioMock.post(firebaseURL, data: userCredentials);
    expect(result.statusCode, 201);
    expect(AuthResultModel.fromJson(result.data), isA<AuthResultModel>());
  });

  test('should return a list of products', () async {
    dioAdapter.onGet(
      firebaseURL,
      (server) => server.reply(
        200,
        jsonDecode(fireBaseResponseList),
        delay: Duration(seconds: 1),
      ),
    );
    final result = await dioMock.get(firebaseURL);

    expect(result.statusCode, 200);
    expect(result.data, isA<List>());
  });
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/auth_exceptions.dart';
import 'package:shop_clean_arch/app/shop/external/datasources/firebase_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import '../../utils/firebase_response.dart';

class DioMock extends Mock implements Dio {
  @override
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return super.noSuchMethod(Invocation.getter(#post),
        returnValue: Future<Response<AuthResultModel>>.value(
          Response<AuthResultModel>(
              requestOptions: RequestOptions(path: ''),
              data: AuthResultModel()),
        ));
  }
}

main() {
  final dio = DioMock();
  final direbaseDataSource = FirebaseDataSource(dio);
  test('should return a AuthResultModel', () async {
    when(dio.post('')).thenAnswer((_) async => Response(
        data: firebaseResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: '')));
    final result = direbaseDataSource.authWithEmail('a', 'a');
    expect(result, completes);
  });

  test('should return an error if status code is not 200', () async {
    when(dio.post('')).thenAnswer((_) async => Response(
        data: firebaseResponse,
        statusCode: 401,
        requestOptions: RequestOptions(path: '')));
    final result = direbaseDataSource.authWithEmail('a', 'a');
    expect(result, throwsA(isA<AuthDataSourceException>()));
  });

  test('should return an Exception if dio returns error', () async {
    when(dio.post('')).thenAnswer((_) async => Response(
        data: firebaseResponse,
        statusCode: 500,
        requestOptions: RequestOptions(path: '')));
    final result = direbaseDataSource.authWithEmail('a', 'a');
    expect(result, throwsA(isA<Exception>()));
  });
}

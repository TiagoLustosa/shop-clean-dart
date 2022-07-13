import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/auth_with_email.dart';
import 'package:shop_clean_arch/app/shop/infra/dependency_injection/dependency_injection_config.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import 'package:shop_clean_arch/app/shop/utils/constants.dart';

import '../../utils/firebase_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  test('should return usecase without error', () {
    configureDependencies();
    final usecase = getIt<IAuthWithEmail>();
    expect(usecase, isA<IAuthWithEmail>());
  });

  test('should return an AuthResultModel', () async {
    configureDependencies();
    when(dio.post(firebaseURL)).thenAnswer((_) async => Response(
        data: jsonDecode(firebaseResponse),
        statusCode: 200,
        requestOptions: RequestOptions(path: '')));
    final usecase = getIt<IAuthWithEmail>();
    final result = await usecase('tiago@gmail.com', 'teste123');
    expect(result, isA<AuthResultModel>());
  });
}
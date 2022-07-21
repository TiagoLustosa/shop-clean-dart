import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth_credentials.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/auth_exceptions.dart';
import 'package:shop_clean_arch/app/shop/external/datasources/firebase_product_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/dependency_injection/dependency_injection_config.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';
import 'package:shop_clean_arch/app/shop/utils/constants.dart';
import '../../utils/firebase_response.dart';

main() {
  final dioMock = Dio(BaseOptions());

  final dioAdapter = DioAdapter(dio: dioMock);
  FirebaseProductDataSource firebaseDataSource =
      FirebaseProductDataSource(dioMock);
  dioMock.httpClientAdapter = dioAdapter;

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

  test('should return a productResult model when addProduct', () async {
    dioAdapter.onPost(
      productBaseURL,
      (server) => server.reply(
        200,
        fireBaseResponseAdd,
        delay: Duration(seconds: 1),
      ),
      data: fireBaseResponseAdd,
    );
    final result =
        await dioMock.post(productBaseURL, data: fireBaseResponseAdd);
    expect(result.statusCode, 200);
    expect(ProductResultModel.fromJson(jsonDecode(result.data)),
        isA<ProductResultModel>());
  });
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_arch/app/shop/infra/rest_client/rest_client.dart';

@Injectable(as: IRestClient)
class CustomDio implements IRestClient {
  final SharedPreferences _sharedPreferences;
  final Dio _dio;

  @override
  Dio instance() => _dio;

  CustomDio(this._sharedPreferences, this._dio) {
    final authResult = _sharedPreferences.getString('userLogged');
    final json = jsonDecode(authResult!);
    if (json['token'] != null) {
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        options.queryParameters['auth'] = json['token'].toString();
        return handler.next(options);
      }));
    }
  }
}

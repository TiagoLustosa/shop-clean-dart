import 'package:dio/dio.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/auth_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import 'package:shop_clean_arch/app/shop/utils/constants.dart';

import '../../infra/datasources/auth_datasource.dart';

class FirebaseDataSource implements IAuthDataSource {
  final Dio _dio;

  FirebaseDataSource(this._dio);
  @override
  Future<AuthResultModel> authWithEmail(String? email, String? password) async {
    final response = await _dio.post(firebaseURL, data: {
      'email': email,
      'password': password,
      'returnSecureToken': true
    });
    print(response.data);
    if (response.statusCode == 200) {
      return AuthResultModel.fromMap(response.data);
    } else {
      print(response);
      throw AuthDataSourceException(
          message:
              'Error while trying to authenticate with email and password');
    }
  }
}

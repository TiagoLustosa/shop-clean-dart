import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/auth_datasource.dart';
import '../../domain/entities/auth_credentials.dart';
import '../../domain/exceptions/auth_exceptions.dart';
import '../../infra/models/auth_result_model.dart';
import '../../utils/constants.dart';

@Injectable(as: IAuthDataSource)
class FirebaseAuthDataSource implements IAuthDataSource {
  final Dio _dio;

  FirebaseAuthDataSource(this._dio);
  @override
  Future<AuthResultModel> authWithEmail(AuthCredentials credentials) async {
    final response = await _dio.post(firebaseURL, data: {
      'email': credentials.email,
      'password': credentials.password,
      'returnSecureToken': true
    });
    if (response.statusCode == 200) {
      return AuthResultModel.fromJson(response.data);
    } else {
      throw AuthDataSourceException(
          message:
              'Error while trying to authenticate with email and password');
    }
  }
}

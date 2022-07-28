import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/user_data_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/user_data_local_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';

@Injectable(as: IUserDataLocalDataSource)
class UserDataLocalDataSource implements IUserDataLocalDataSource {
  final SharedPreferences _sharedPreferences;

  UserDataLocalDataSource(this._sharedPreferences);
  @override
  AuthResultModel getUserLocalData() {
    final result = _sharedPreferences.getString('userData');
    if (result != null) {
      return AuthResultModel.fromJson(jsonDecode(result));
    } else {
      throw UserDataNotFoundException('User data not found');
    }
  }

  @override
  Future<bool> setUserLocalData(AuthResultModel userData) async {
    final result =
        await _sharedPreferences.setString('userData', jsonEncode(userData));
    if (result == true) {
      return true;
    } else {
      throw UserDataExceptions();
    }
  }

  @override
  Future<bool> deleteUserLocalData() {
    // TODO: implement deleteUserLocalData
    throw UnimplementedError();
  }
}

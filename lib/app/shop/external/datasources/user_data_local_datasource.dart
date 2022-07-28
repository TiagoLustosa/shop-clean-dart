import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/user_data_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/user_data_local_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';

class UserDataLocalDataSource implements IUserDataLocalDataSource {
  final SharedPreferences _sharedPreferences;

  UserDataLocalDataSource(this._sharedPreferences);
  @override
  Future<AuthResultModel> getUserLocalData() async {
    final result = _sharedPreferences.getString('userData');
    if (result != null) {
      return AuthResultModel.fromJson(result);
    } else {
      throw UserDataNotFoundException('User data not found');
    }
  }

  @override
  Future<bool> setUserLocalData(Auth auth) {
    // TODO: implement setUserLocalData
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteUserLocalData() {
    // TODO: implement deleteUserLocalData
    throw UnimplementedError();
  }
}

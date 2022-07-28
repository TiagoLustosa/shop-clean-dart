import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/auth_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';

abstract class IUserDataLocalDataSource {
  Future<AuthResultModel> getUserLocalData();
  Future<bool> setUserLocalData(Auth auth);
  Future<bool> deleteUserLocalData();
}

import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/user_data_exceptions.dart';

abstract class IUserDataRepository {
  Future<Either<IUserDataExceptions, Auth>> getUserLocalData();
  Future<Either<IUserDataExceptions, bool>> setUserLocalData(Auth userData);
  Future<Either<IUserDataExceptions, bool>> deleteUserLocalData();
}

import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/auth_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';

abstract class IAuthLocalDataSource {
  Future<Either<IAuthExceptions, AuthResultModel>> getAuth();
  Future<Either<IAuthExceptions, bool>> setAuth(AuthResultModel auth);
  Future<Either<IAuthExceptions, bool>> deleteAuth();
}

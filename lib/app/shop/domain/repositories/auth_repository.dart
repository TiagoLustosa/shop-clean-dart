import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth_credentials.dart';
import '../entities/auth.dart';
import '../exceptions/auth_exceptions.dart';

abstract class IAuthRepository {
  Future<Either<IAuthExceptions, Auth>> authWithEmail(
      AuthCredentials credentials);
}

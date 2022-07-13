import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/auth_datasource.dart';
import '../../domain/exceptions/auth_exceptions.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImplements implements IAuthRepository {
  final IAuthDataSource _authDataSource;

  AuthRepositoryImplements(this._authDataSource);

  @override
  Future<Either<IAuthExceptions, Auth?>> authWithEmail(
      String? email, String? password) async {
    try {
      final result = await _authDataSource.authWithEmail(email, password);
      return Right(result);
    } on AuthDataSourceException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AuthDataSourceException(message: e.toString()));
    }
  }
}

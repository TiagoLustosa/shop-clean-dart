import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/auth_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import '../../domain/entities/auth_credentials.dart';
import '../../domain/exceptions/auth_exceptions.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImplements implements IAuthRepository {
  final IAuthDataSource _authDataSource;

  AuthRepositoryImplements(this._authDataSource);

  @override
  Future<Either<IAuthExceptions, AuthResultModel>> authWithEmail(
      AuthCredentials credentials) async {
    try {
      final result = await _authDataSource.authWithEmail(credentials);
      return Right(result);
    } on AuthDataSourceException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AuthDataSourceException(message: e.toString()));
    }
  }
}

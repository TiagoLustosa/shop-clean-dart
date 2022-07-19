import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth_credentials.dart';
import '../../entities/auth.dart';
import '../../exceptions/auth_exceptions.dart';
import '../../repositories/auth_repository.dart';
import '../base_usecase/base_usecase.dart';

class AuthWithEmail implements UseCase<Auth, AuthCredentials> {
  final IAuthRepository _authRepository;

  AuthWithEmail(this._authRepository);

  @override
  Future<Either<IAuthExceptions, Auth>> call(credentials) async {
    if (credentials.email == null ||
        credentials.password == null ||
        credentials.email!.isEmpty ||
        credentials.password!.isEmpty) {
      return Left(InvalidTextError());
    }
    return _authRepository.authWithEmail(credentials);
  }
}

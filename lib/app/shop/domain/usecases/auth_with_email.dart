import 'package:dartz/dartz.dart';
import '../entities/auth.dart';
import '../exceptions/auth_exceptions.dart';
import '../repositories/auth_repository.dart';

abstract class IAuthWithEmail {
  Future<Either<IAuthExceptions, Auth?>> call(
    String? email,
    String? password,
  );
}

class AuthWithEmail implements IAuthWithEmail {
  final IAuthRepository _authRepository;

  AuthWithEmail(this._authRepository);

  @override
  Future<Either<IAuthExceptions, Auth?>> call(
      String? email, String? password) async {
    if (email == null ||
        password == null ||
        email.isEmpty ||
        password.isEmpty) {
      return Left(InvalidTextError());
    }
    return _authRepository.authWithEmail(email, password);
  }
}

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth_credentials.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/user_data_repository.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import '../../entities/auth.dart';
import '../../exceptions/auth_exceptions.dart';
import '../../repositories/auth_repository.dart';
import '../base_usecase/base_usecase.dart';

@Injectable(as: UseCase<Auth, AuthCredentials>)
class AuthWithEmail implements UseCase<Auth, AuthCredentials> {
  final IAuthRepository _authRepository;
  final IUserDataRepository _userDataRepository;

  AuthWithEmail(this._authRepository, this._userDataRepository);

  @override
  Future<Either<IAuthExceptions, Auth>> call(credentials) async {
    if (credentials.email == null ||
        credentials.password == null ||
        credentials.email!.isEmpty ||
        credentials.password!.isEmpty) {
      return Left(InvalidTextError());
    }
    final result = await _authRepository.authWithEmail(credentials);
    return result.fold(
      (l) => Left(l),
      (r) {
        _userDataRepository.setUserLocalData(r);
        return Right(r);
      },
    );
  }
}

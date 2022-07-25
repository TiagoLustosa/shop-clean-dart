import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth_credentials.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import '../../entities/auth.dart';
import '../../exceptions/auth_exceptions.dart';
import '../../repositories/auth_repository.dart';
import '../base_usecase/base_usecase.dart';

@Injectable(as: UseCase<Auth, AuthCredentials>)
class AuthWithEmail implements UseCase<Auth, AuthCredentials> {
  final IAuthRepository _authRepository;
  final SharedPreferences _prefs;

  AuthWithEmail(this._authRepository, this._prefs);

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
        final authShared = r as AuthResultModel;
        _prefs.setString('userLogged', jsonEncode(authShared.toMap()));
        return Right(r);
      },
    );
  }
}

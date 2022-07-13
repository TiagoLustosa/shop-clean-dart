import 'package:dartz/dartz.dart';

import '../entities/auth.dart';
import '../exceptions/auth_exceptions.dart';

abstract class IAuthRepository {
  Future<Either<IAuthExceptions, Auth?>> authWithEmail(
      String? email, String? password);
}

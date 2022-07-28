import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/user_data_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/user_data_repository.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/user_data_local_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';

@Injectable(as: IUserDataRepository)
class UserDataRepositoryImplements implements IUserDataRepository {
  final IUserDataLocalDataSource _userDataLocalDataSource;

  UserDataRepositoryImplements(this._userDataLocalDataSource);
  @override
  Future<Either<IUserDataExceptions, Auth>> getUserLocalData() async {
    try {
      final result = await _userDataLocalDataSource.getUserLocalData();
      return Right(result);
    } on UserDataNotFoundException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UserDataNotFoundException(e.toString()));
    }
  }

  @override
  Future<Either<IUserDataExceptions, bool>> setUserLocalData(
      Auth userData) async {
    try {
      final result = await _userDataLocalDataSource
          .setUserLocalData(userData as AuthResultModel);
      return Right(result);
    } on UserDataNotFoundException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UserDataNotFoundException(e.toString()));
    }
  }

  @override
  Future<Either<IUserDataExceptions, bool>> deleteUserLocalData() {
    // TODO: implement deleteUserLocalData
    throw UnimplementedError();
  }
}

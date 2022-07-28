import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/user_data_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/user_usecase/contracts/set_user_local_data_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';

@Injectable(as: ISetUserLocalDataUsecaseContract)
class SetUserLocalDataUseCase implements ISetUserLocalDataUsecaseContract {
  final IUserDataRepository _userLocalDataRepository;

  SetUserLocalDataUseCase(this._userLocalDataRepository);

  @override
  Future<Either<Exception, bool>> call(AuthResultModel userData) async {
    final result = await _userLocalDataRepository.setUserLocalData(userData);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}

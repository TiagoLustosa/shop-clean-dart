import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/user_data_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/user_data_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/base_usecase/base_usecase.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/user_usecase/contracts/get_user_local_data_usecase_contract.dart';

@Injectable(as: IGetUserLocalDataUsecaseContract)
class GetUserLocaDataUseCase implements IGetUserLocalDataUsecaseContract {
  final IUserDataRepository _userDataRepository;

  GetUserLocaDataUseCase(this._userDataRepository);

  @override
  Future<Either<IUserDataExceptions, Auth>> call(NoParams noParams) async {
    final result = await _userDataRepository.getUserLocalData();
    return result.fold(
        (l) => Left(UserDataNotFoundException(l.toString())), (r) => Right(r));
  }
}

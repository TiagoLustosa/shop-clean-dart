import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/base_usecase/base_usecase.dart';

abstract class IRemoveFromCartUseCase implements UseCase<bool, String> {
  @override
  Future<Either<Exception, bool>> call(String productId, {String? userId});
}

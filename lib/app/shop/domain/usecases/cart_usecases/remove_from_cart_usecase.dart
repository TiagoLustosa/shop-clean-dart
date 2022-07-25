import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/cart_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/cart_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/contracts/remove_from_cart_usecase_contract.dart';

@Injectable(as: IRemoveFromCartUseCase)
class RemoveFromCartUseCase implements IRemoveFromCartUseCase {
  final ICartRepository _cartRepository;

  RemoveFromCartUseCase(this._cartRepository);
  @override
  Future<Either<ICartExceptions, bool>> call(String productId) async {
    final result =
        await _cartRepository.removeFromCart('userIdAqui', productId);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}

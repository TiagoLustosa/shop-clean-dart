import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/cart_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/cart_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/contracts/get_from_cart_usecase_contract.dart';

@Injectable(as: IGetFromCartUseCase)
class GetFromCartUseCase implements IGetFromCartUseCase {
  final ICartRepository _cartRepository;

  GetFromCartUseCase(this._cartRepository);

  @override
  Future<Either<ICartExceptions, Cart?>> call(String userIdParam) async {
    final cart = await _cartRepository.getCart(userIdParam);
    return cart.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}

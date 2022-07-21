import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart_item.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/product.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/cart_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/cart_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/contracts/add_to_cart_usecase_contract.dart';

@Injectable(as: IAddToCartUseCase)
class AddToCartUseCase implements IAddToCartUseCase {
  final ICartRepository _cartRepository;

  AddToCartUseCase(this._cartRepository);

  @override
  Future<Either<ICartExceptions, Cart>> call(Product product) async {
    final cartItem = CartItem(
        productId: product.id,
        name: product.name,
        price: product.price,
        quantity: 1);
    final cart = await _cartRepository.addToCart(cartItem, 'userId');
    return cart.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}

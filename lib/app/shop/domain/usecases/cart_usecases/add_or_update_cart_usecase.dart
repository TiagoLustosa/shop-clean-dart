import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/product.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/cart_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/cart_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/contracts/add_or_update_cart_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/infra/models/cart_item_result_model.dart';

@Injectable(as: IAddOrUpdateCartUseCase)
class AddOrUpdateCartUseCase implements IAddOrUpdateCartUseCase {
  final ICartRepository _cartRepository;

  AddOrUpdateCartUseCase(this._cartRepository);

  @override
  Future<Either<ICartExceptions, Cart>> call(Product product) async {
    final getCart = await _cartRepository.getCart('userIdAqui');
    CartItemResultModel cartItem = CartItemResultModel(
      id: product.id,
      name: product.name,
      price: product.price,
      quantity: 0,
    );
    getCart.fold((l) => Left(l), (r) {
      Right(r);
      final cartItemExist = r?.cartItemList?.firstWhere(
          (element) => element.id == product.id,
          orElse: () => cartItem);

      cartItem = CartItemResultModel(
        id: cartItemExist!.id,
        name: cartItemExist.name,
        price: cartItemExist.price,
        quantity: cartItemExist.quantity! + 1,
      );
    });
    final cart = await _cartRepository.addOrUpdateCart(cartItem, 'userIdAqui');
    return cart.fold(
      (l) => Left(CartDataSourceException(message: l.toString())),
      (r) => Right(r),
    );
  }
}

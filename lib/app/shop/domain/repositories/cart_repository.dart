import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/cart_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/models/cart_item_result_model.dart';

abstract class ICartRepository {
  Future<Either<ICartExceptions, Cart?>> getCart(String userId);
  Future<Either<ICartExceptions, Cart>> addOrUpdateCart(
      CartItemResultModel cartItem, String userId);
  Future<Either<ICartExceptions, bool>> removeFromCart(
      String userId, String productId);
  Future<Either<ICartExceptions, bool>> clearCart();
}

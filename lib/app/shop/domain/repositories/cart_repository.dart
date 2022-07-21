import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart_item.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/cart_exceptions.dart';

abstract class ICartRepository {
  Future<Either<ICartExceptions, Cart>> getCart(String userId);
  Future<Either<ICartExceptions, Cart>> addToCart(
      CartItem cartItem, String userId);
  Future<Either<ICartExceptions, Cart>> removeFromCart(String productId);
  Future<Either<ICartExceptions, bool>> clearCart();
}

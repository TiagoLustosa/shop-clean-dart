import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:shop_clean_arch/app/shop/infra/models/cart_item_result_model.dart';

abstract class ICartDataSource {
  Future<Cart?> getCart(String userId);
  Future<Cart> addToCart(CartItemResultModel cartItem, String userId);
  Future<bool> removeFromCart(String userId, String productId);
  Future<bool> clearCart(String userId);
}

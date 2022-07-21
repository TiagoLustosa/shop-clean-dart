import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart_item.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/product.dart';

abstract class ICartDataSource {
  Future<Cart> getCart(String userId);
  Future<Cart> addToCart(CartItem cart, String userId);
  Future<void> removeFromCart(Product product);
  Future<void> clearCart();
}

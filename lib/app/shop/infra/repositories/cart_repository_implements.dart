import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/product.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/cart_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart_item.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/cart_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/product_repository.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/cart_datasource.dart';

@Injectable(as: ICartRepository)
class CartRepositoryImplements implements ICartRepository {
  final ICartDataSource _cartDataSource;
  final IProductRepository _productRepository;

  CartRepositoryImplements(this._cartDataSource, this._productRepository);
  @override
  Future<Either<ICartExceptions, Cart>> addToCart(
      CartItem cartItem, String userId) async {
    try {
      final cartResult = await _cartDataSource.addToCart(cartItem, userId);
      return Right(cartResult);
    } on CartDataSourceException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CartDataSourceException(message: e.toString()));
    }
  }

  @override
  Future<Either<ICartExceptions, bool>> clearCart() {
    // TODO: implement clearCart
    throw UnimplementedError();
  }

  @override
  Future<Either<ICartExceptions, Cart>> getCart(String userId) async {
    // TODO: implement getCart
    throw UnimplementedError();
  }

  @override
  Future<Either<ICartExceptions, Cart>> removeFromCart(String productId) {
    // TODO: implement removeFromCart
    throw UnimplementedError();
  }
}

import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/cart_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart_item.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/cart_repository.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/cart_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/cart_item_result_model.dart';

@Injectable(as: ICartRepository)
class CartRepositoryImplements implements ICartRepository {
  final ICartDataSource _cartDataSource;

  CartRepositoryImplements(this._cartDataSource);
  @override
  Future<Either<ICartExceptions, Cart?>> getCart(String userId) async {
    try {
      final cartResult = await _cartDataSource.getCart(userId);
      if (cartResult == null) {
        return const Right(null);
      }
      return Right(cartResult);
    } on CartDataSourceException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CartDataSourceException(message: e.toString()));
    }
  }

  @override
  Future<Either<ICartExceptions, Cart>> addOrUpdateCart(
      CartItemResultModel cartItem, String userId) async {
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
  Future<Either<ICartExceptions, Cart>> updateCart(CartItem cartItem) {
    // TODO: implement updateCart
    throw UnimplementedError();
  }

  @override
  Future<Either<ICartExceptions, bool>> removeFromCart(
      String userId, String productId) async {
    try {
      final result = await _cartDataSource.removeFromCart(userId, productId);
      return Right(result);
    } on CartDataSourceException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CartDataSourceException(message: e.toString()));
    }
  }

  @override
  Future<Either<ICartExceptions, bool>> clearCart(String userId) async {
    try {
      final result = await _cartDataSource.clearCart(userId);
      return Right(result);
    } on CartDataSourceException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CartDataSourceException(message: e.toString()));
    }
  }
}

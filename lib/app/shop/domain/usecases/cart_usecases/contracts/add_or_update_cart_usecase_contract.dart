import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/product.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/base_usecase/base_usecase.dart';

abstract class IAddOrUpdateCartUseCase implements UseCase<Cart, Product> {
  @override
  Future<Either<Exception, Cart>> call(Product product, {String? userId});
}

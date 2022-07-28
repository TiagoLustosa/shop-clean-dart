import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/cart_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/contracts/clear_cart_usecase_contract.dart';

@Injectable(as: IClearCartUseCase)
class ClearCartUseCase implements IClearCartUseCase {
  final ICartRepository _cartRepository;

  ClearCartUseCase(this._cartRepository);
  @override
  Future<Either<Exception, bool>> call(String userId) async {
    final result = await _cartRepository.clearCart(userId);
    return result.fold((l) => Left(l), (r) => Right(r));
  }
}

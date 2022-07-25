import 'package:shop_clean_arch/app/shop/domain/entities/order_item.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/base_usecase/base_usecase.dart';

abstract class IGetOrderUseCase implements UseCase<List<OrderItem>, String> {}

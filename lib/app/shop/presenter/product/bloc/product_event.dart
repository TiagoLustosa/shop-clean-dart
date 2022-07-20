import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';

import '../../../domain/entities/product.dart';

abstract class ProductEvent {}

// class GetProduct extends ProductEvent {
//   final String id;

//   GetProduct(this.id);
// }

class AddProduct extends ProductEvent {
  final ProductResultModel product;

  AddProduct(this.product);
}

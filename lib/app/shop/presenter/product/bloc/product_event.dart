import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';

abstract class ProductEvent {}

class GetProduct extends ProductEvent {
  final String id;

  GetProduct(this.id);
}

class AddProduct extends ProductEvent {
  final ProductResultModel product;

  AddProduct(this.product);
}

class UpdateProduct extends ProductEvent {
  final ProductResultModel product;

  UpdateProduct(this.product);
}

class DeleteProduct extends ProductEvent {
  final String id;

  DeleteProduct(this.id);
}

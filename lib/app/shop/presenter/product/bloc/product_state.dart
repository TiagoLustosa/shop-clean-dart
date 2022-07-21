import '../../../domain/entities/product.dart';

abstract class ProductState {}

class ProductSuccess extends ProductState {
  final Product? product;
  ProductSuccess(this.product);
}

class ProductDeletedSuccess extends ProductState {
  final bool deleted;
  ProductDeletedSuccess(this.deleted);
}

class ProductStart implements ProductState {
  const ProductStart();
}

class ProductLoading implements ProductState {
  const ProductLoading();
}

class ProductError implements ProductState {
  final Exception error;
  ProductError(this.error);
}

abstract class ProductEvent {}

class GetProduct extends ProductEvent {
  final String id;

  GetProduct(this.id);
}

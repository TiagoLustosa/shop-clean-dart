import '../../domain/entities/product.dart';

class ProductResultModel extends Product {
  final String? id;
  final String? name;
  final String? description;
  final double? price;
  final String? imageUrl;
  bool isFavorite = false;

  ProductResultModel(
      {this.id, this.name, this.description, this.price, this.imageUrl});

  static fromMap(Map<String, dynamic> map) {
    return ProductResultModel(
      id: map['key'],
      description: map['description'],
      name: map['name'],
      price: map['price'],
      imageUrl: map['imageUrl'],
    );
  }

  toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory ProductResultModel.fromJson(Map<String, dynamic> json) {
    return ProductResultModel(
      id: json['key'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}

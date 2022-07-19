abstract class IProductExceptions implements Exception {}

class InvalidIdException implements IProductExceptions {}

class EmptyList implements IProductExceptions {}

class ProductDataSourceException implements IProductExceptions {
  final String message;

  String getErrorMessage() => message;

  ProductDataSourceException({required this.message});
}

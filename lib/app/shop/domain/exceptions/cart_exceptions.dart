abstract class ICartExceptions implements Exception {}

class CartDataSourceException implements ICartExceptions {
  final String message;

  String getErrorMessage() => message;

  CartDataSourceException({required this.message});
}

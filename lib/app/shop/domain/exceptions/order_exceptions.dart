abstract class IOrderExceptions implements Exception {}

class OrderDataSourceException implements IOrderExceptions {
  final String message;

  String getErrorMessage() => message;

  OrderDataSourceException({required this.message});
}

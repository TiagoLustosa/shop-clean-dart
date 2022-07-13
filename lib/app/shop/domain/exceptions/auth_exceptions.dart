abstract class IAuthExceptions implements Exception {}

class InvalidTextError implements IAuthExceptions {}

class AuthDataSourceException implements IAuthExceptions {
  final String message;

  AuthDataSourceException({required this.message});
}

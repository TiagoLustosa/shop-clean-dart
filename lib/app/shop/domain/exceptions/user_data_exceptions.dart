abstract class IUserDataExceptions implements Exception {}

class UserDataExceptions implements IUserDataExceptions {}

class UserDataNotFoundException extends IUserDataExceptions {
  final String message;

  UserDataNotFoundException(this.message);
}

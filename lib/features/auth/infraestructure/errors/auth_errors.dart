class WrongCredentials implements Exception {}

class InvalidToken implements Exception {}

class ConnectionTimeOut implements Exception {}

class CustomError implements Exception {
  final String errorMessage;
  final bool loggedRequired;

  CustomError({required this.errorMessage, this.loggedRequired = false});
}

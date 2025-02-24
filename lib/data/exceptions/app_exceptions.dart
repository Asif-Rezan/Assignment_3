class AppExceptions implements Exception {
  final String _message;
  final String _prefix;

  AppExceptions(this._message, this._prefix);

  @override
  String toString() => '$_message$_prefix';
}

class NoInternetException extends AppExceptions {
  NoInternetException([String message = '']) : super(message, 'No internet connection: ');
}

class FetchDataException extends AppExceptions {
  FetchDataException([String message = '']) : super(message, 'Error During Communication: ');
}

class BadRequestException extends AppExceptions {
  BadRequestException([String message = '']) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends AppExceptions {
  UnauthorisedException([String message = '']) : super(message, 'Unauthorised: ');
}


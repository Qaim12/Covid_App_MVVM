

class AppException implements Exception{

  final _messege;
  final _prefix;

  AppException(this._messege, this._prefix);
  String toString(){
    return '$_prefix$_messege';
  }
}

class FetchDataException extends AppException{


  FetchDataException([String? message]) : super(message, 'Error during communication');
}

class BadRequestException extends AppException{

  BadRequestException([String? message]) : super(message, 'Invalid Request');
}

class UnauthorizedException extends AppException{

  UnauthorizedException([String? message]) : super(message, 'Unauthorised Request');
}
class InvalidInputException extends AppException{

  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}
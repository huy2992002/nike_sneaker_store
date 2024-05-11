class Failure {
  Failure(this.responseCode, this.message);

  final int responseCode;
  final String message;
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int unAuthorized = 401;
  static const int forbidden = 403;
  static const int internalSeverError = 500;
  static const int notFound = 404;
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int errorDefault = -7;
}

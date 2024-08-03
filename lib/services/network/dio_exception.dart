import 'package:dio/dio.dart';

class NetworkError implements Exception {
  late String errorMessage;

  NetworkError.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        errorMessage = 'Request to the server was cancelled.';

      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timed out.';

      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receiving timeout occurred.';

      case DioExceptionType.sendTimeout:
        errorMessage = 'Request send timeout.';

      case DioExceptionType.badResponse:
        errorMessage = _handleStatusCode(dioException.response?.statusCode);

      case DioExceptionType.connectionError:
        if ((dioException.message ?? "").contains('SocketException')) {
          errorMessage = 'No Internet.';
        }
        errorMessage = 'Unexpected error occurred.';

      default:
        errorMessage = 'Something went wrong';
    }
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request.';
      case 401:
        return 'Authentication failed.';
      case 403:
        return 'The authenticated user is not allowed to access the specified API endpoint.';
      case 404:
        return 'The requested resource does not exist.';
      case 405:
        return 'Method not allowed. Please check the Allow header for the allowed HTTP methods.';
      case 415:
        return 'Unsupported media type. The requested content type or version number is invalid.';
      case 422:
        return 'Data validation failed.';
      case 429:
        return 'Too many requests.';
      case 500:
        return 'Internal server error.';
      default:
        return 'Oops something went wrong!';
    }
  }

  @override
  String toString() => errorMessage;
}

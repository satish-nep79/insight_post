import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:insight_post/services/network/dio_exception.dart';
import 'package:insight_post/utils/log_helper.dart';

class DioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final errorMessage = NetworkError.fromDioError(err).toString();
    var error = DioException(
        requestOptions: err.requestOptions,
        error: err.error,
        message: errorMessage,
        response: err.response,
        stackTrace: err.stackTrace,
        type: err.type);
    super.onError(error, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = "${options.baseUrl}${options.path}";
    LogHelper.info(
        title: requestPath,
        message: "Request ${options.method}",
        error: options.data);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var options = response.requestOptions;
    final requestPath = "${options.baseUrl}${options.path}";
    LogHelper.info(title: requestPath, message: response.data.toString());
    super.onResponse(response, handler);
  }
}

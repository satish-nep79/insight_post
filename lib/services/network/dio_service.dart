import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:insight_post/common/constsnts/apis.dart';
import 'package:insight_post/common/constsnts/app_time_values.dart';
import 'package:insight_post/services/network/dio_interceptor.dart';
import 'package:insight_post/utils/log_helper.dart';

class DioService {
  static Dio? _dio;
  static final DioService _instance = DioService._privateConstructor();

  // Singleton instance
  static DioService get instance => _instance;

  DioService._privateConstructor() {
    _initDio();
  }

  static void reInitDio() {
    _dio = null;
    _initDio();
  }

  static void _initDio() {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: Apis.baseUrl,
        connectTimeout:
            const Duration(milliseconds: AppTimeValues.dioConnectionTimeout),
        receiveTimeout:
            const Duration(milliseconds: AppTimeValues.dioReceiveTimeout),
        responseType: ResponseType.plain,
      ),
    )..interceptors.addAll([DioInterceptor()]);
  }

  static Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      _initDio();
      var response = await _dio!.get(
        endPoint,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return response;
    } catch (e, s) {
      LogHelper.error(title: endPoint, error: e, stackTrace: s);
      rethrow;
    }
  }

  static Future<Response> post(
      {required String endPoint,
      Map<String, dynamic>? headers,
      Object? body}) async {
    try {
      _initDio();
      var response = await _dio!.post(
        endPoint,
        data: json.encode(body),
        options: Options(
          headers: headers,
        ),
      );

      return response;
    } catch (e, s) {
      LogHelper.error(
          title: endPoint, error: e, stackTrace: s, message: "Throwing error");
      rethrow;
    }
  }
}

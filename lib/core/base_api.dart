import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';

export 'dart:io';
export 'package:http_parser/http_parser.dart';

class BaseAPI {
  static String get baseUrl =>
      kDebugMode ? 'https://api.nstack.in/' : 'https://api.nstack.in/';

  Dio dio([String? contentType]) {
    final dio = Dio(
      BaseOptions(
        baseUrl: '${baseUrl}v1/',
        sendTimeout: const Duration(seconds: 60),
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        contentType: contentType ?? Headers.formUrlEncodedContentType,
        validateStatus: (int? s) => s! < 500,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (res, handler) {
          log('${res.baseUrl}${res.path}');

          const token = 'N/A';

          if (token != '') res.headers['Authorization'] = 'Bearer $token';
          return handler.next(res);
        },
        onResponse: (res, handler) async {
          log(res.statusCode);
          log(res.data);

          return handler.next(res);
        },
      ),
    );

    return dio;
  }

  void log(dynamic data) {
    if (kDebugMode) {
      print(data);
    }
  }

  String error(dynamic data) {
    if (data.toString().contains('DOCTYPE')) {
      return 'An error occurred';
    }

    if (data == null) {
      return 'No data provided';
    }

    return 'An error occured, please try again!';
  }
}

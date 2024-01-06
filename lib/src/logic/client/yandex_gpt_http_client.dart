import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:yandex_gpt_rest_api/src/models/errors/api_error.dart';

/// Facade for working with `Dio`
class YandexGptHttpClient {
  final Dio _dio;

  const YandexGptHttpClient(Dio dio) : _dio = dio;

  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, dynamic>? body,
    CancelToken? cancelToken,
  }) async {
    late final Response<Map<String, Object>> response;

    try {
      response = await _dio.post<Map<String, Object>>(
        url,
        data: jsonEncode(body),
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      final apiError = ApiError.tryParseJson(
        (e.response?.data ?? {}) as Map<String, Object>,
      );
      if (apiError == null) rethrow;
      throw apiError;
    }

    final jsonBody = response.data ?? {};
    return jsonBody;
  }
}

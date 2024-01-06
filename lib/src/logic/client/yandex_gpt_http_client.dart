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
    late final Response<String> response;

    try {
      response = await _dio.post<String>(
        url,
        data: jsonEncode(body),
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      final body =
          jsonDecode(e.response?.data as String? ?? "") as Map<String, dynamic>;
      final apiError = ApiError.tryParseJson(body);
      if (apiError == null) rethrow;
      throw apiError;
    }

    final jsonBody = jsonDecode(response.data ?? "") as Map<String, dynamic>;
    return jsonBody;
  }
}

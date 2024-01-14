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
    return await _fetch(
      _dio.post<String>(
        url,
        data: jsonEncode(body),
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? body,
    CancelToken? cancelToken,
  }) async {
    return await _fetch(
      _dio.get<String>(
        url,
        data: jsonEncode(body),
        cancelToken: cancelToken,
      ),
    );
  }

  /// A wrapper for handling [ApiError] responses.
  Future<Map<String, dynamic>> _fetch(Future<Response<String>> request) async {
    late final Response<String> response;

    try {
      response = await request;
    } on DioException catch (e) {
      // Check if response contains [ApiError].
      final body = jsonDecode(e.response?.data as String? ?? "{}");
      final apiError =
          ApiError.tryParseJson(body is Map<String, dynamic> ? body : {});
      if (apiError == null) rethrow;
      throw apiError;
    }

    final jsonBody = jsonDecode(response.data!) as Map<String, dynamic>;
    return jsonBody;
  }
}

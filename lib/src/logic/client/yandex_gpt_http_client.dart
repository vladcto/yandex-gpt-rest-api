import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:yandex_gpt_rest_api/src/models/errors/api_error.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/headers.dart';

/// Facade for working with `http.Client`
class YandexGptHttpClient {
  final Dio _dio;
  final Map<String, String> _authHeader;

  YandexGptHttpClient({
    required BaseOptions options,
    required String authToken,
    required String catalog,
  }) : this._(
          dio: Dio(options),
          authHeader: {
            authHeaderName: authToken,
            catalogIdHeaderName: catalog,
          },
        );

  const YandexGptHttpClient._({
    required Dio dio,
    required Map<String, String> authHeader,
  })  : _authHeader = authHeader,
        _dio = dio;

  void changeToken(String authToken) {
    _authHeader[authHeaderName] = authToken;
  }

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
      if(apiError == null) rethrow;
      throw apiError;
    }

    final jsonBody = response.data ?? {};
    return jsonBody;
  }
}

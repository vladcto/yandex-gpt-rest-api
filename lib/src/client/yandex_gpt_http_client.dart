import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:http/http.dart';
import 'package:yandex_gpt_rest_sdk/src/client/api_cancel_token.dart';
import 'package:yandex_gpt_rest_sdk/src/models/errors/api_error.dart';

class YandexGptHttpClient {
  final Client client;
  final Map<String, String> authHeader;

  YandexGptHttpClient({
    required this.client,
    required String token,
    required String catalog,
  }) // TODO: make it a constant
  : authHeader = {
          "Authorization": "Bearer $token",
          "x-folder-id": catalog,
        };

  Future<Map<String, dynamic>> post(
    Uri url, {
    Map<String, dynamic>? body,
    ApiCancelToken? cancelToken,
  }) async {
    final request = CancelableOperation.fromFuture(
      client.post(url, headers: authHeader),
    );
    cancelToken?.attachCancellable(request);

    final Response response;
    try {
      response = await request.value;
    } on ClientException {
      throw NetworkApiError();
    } on HttpException {
      throw NetworkApiError();
    } finally {
      cancelToken?.detachCancellable(request);
    }

    final jsonBody = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 200) {
      if (jsonBody["error"] != null) {
        throw ContractApiError.fromJson(
          jsonBody["error"] as Map<String, dynamic>,
        );
      }
      throw NetworkApiError(
        statusCode: response.statusCode,
        body: response.body,
      );
    }
    return jsonBody;
  }
}

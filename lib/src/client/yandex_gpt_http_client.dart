import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:http/http.dart';
import 'package:yandex_gpt_rest_sdk/src/client/api_cancel_token.dart';

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
    Uri url,
    ApiCancelToken? cancelToken,
  ) async {
    final operation = CancelableOperation.fromFuture(
      client.post(url, headers: authHeader),
    );
    cancelToken?.attachCancellable(operation);
    final res = operation.then(
      (res) {
        cancelToken?.detachCancellable(operation);
        return jsonDecode(res.body) as Map<String, dynamic>;
      },
      onCancel: () => throw Exception(),
      onError: (e, st) => throw e,
    );
    return await res.value;
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:http/http.dart';
import 'package:yandex_gpt_rest_api/src/logic/helper/api_cancel_token.dart';
import 'package:yandex_gpt_rest_api/src/models/errors/api_error.dart';

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
    final Response? response;
    final request = CancelableOperation.fromFuture(
      client.post(
        url,
        body: jsonEncode(body),
        headers: authHeader,
      ),
    );

    cancelToken?.attachCancellable(request);
    response = await request.valueOrCancellation(null);
    cancelToken?.detachCancellable(request);
    if (response == null) {
      throw CanceledError();
    }

    final jsonBody =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    if (response.statusCode != 200) {
      throw ContractApiError.tryParseJson(jsonBody) ??
          ShortApiError(
            code: -1,
            error: "Unknown error",
            message: "Unknown error format $jsonBody",
            details: [],
          );
    }
    return jsonBody;
  }
}

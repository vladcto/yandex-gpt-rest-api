import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:http/http.dart';
import 'package:yandex_gpt_rest_api/src/logic/helper/api_cancel_token.dart';
import 'package:yandex_gpt_rest_api/src/models/errors/api_error.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/headers.dart';

/// Facade for working with `http.Client`
class YandexGptHttpClient {
  final Client _client;
  final Map<String, String> _authHeader;

  YandexGptHttpClient({
    required Client client,
    required String authToken,
    required String catalog,
  }) : this._(
          client: client,
          authHeader: {
            authHeaderName: authToken,
            catalogIdHeaderName: catalog,
          },
        );

  const YandexGptHttpClient._({
    required Client client,
    required Map<String, String> authHeader,
  })  : _authHeader = authHeader,
        _client = client;

  void changeToken(String authToken) {
    _authHeader[authHeaderName] = authToken;
  }

  Future<Map<String, dynamic>> post(
    Uri url, {
    Map<String, dynamic>? body,
    ApiCancelToken? cancelToken,
  }) async {
    final Response? response;
    final request = CancelableOperation.fromFuture(
      _client.post(
        url,
        body: jsonEncode(body),
        headers: _authHeader,
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

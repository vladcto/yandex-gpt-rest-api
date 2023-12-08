import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yandex_gpt_rest_sdk/src/client/api_cancel_token.dart';
import 'package:yandex_gpt_rest_sdk/src/client/yandex_gpt_api.dart';
import 'package:yandex_gpt_rest_sdk/src/client/yandex_gpt_http_client.dart';
import 'package:yandex_gpt_rest_sdk/src/models/embeddings/embedding_request.dart';
import 'package:yandex_gpt_rest_sdk/src/models/embeddings/embedding_response.dart';
import 'package:yandex_gpt_rest_sdk/src/models/text_generation/async_response/text_generation_async_response.dart';
import 'package:yandex_gpt_rest_sdk/src/models/text_generation/request/text_generation_request.dart';
import 'package:yandex_gpt_rest_sdk/src/models/text_generation/sync_response/text_generation_response.dart';
import 'package:yandex_gpt_rest_sdk/src/models/tokenizer/tokenize_response.dart';
import 'package:yandex_gpt_rest_sdk/src/models/tokenizer/tokenize_text_request.dart';
import 'package:yandex_gpt_rest_sdk/src/utils/constants/url_paths.dart';

class YandexGptApiClient implements YandexGptApi {
  final YandexGptHttpClient _client;

  YandexGptApiClient({required String token, String? catalog})
      : this.withHttpClient(
          client: http.Client(),
          token: token,
          catalog: catalog,
        );

  YandexGptApiClient.withHttpClient({
    required http.Client client,
    required String token,
    String? catalog,
  }) : _client = YandexGptHttpClient(
          client: client,
          token: token,
          catalog: catalog ?? "",
        );

  @override
  Future<TextGenerationResponse> generateText(
    TextGenerationRequest request, {
    ApiCancelToken? cancelToken,
  }) async {
    final res = await _client.post(
      textGenerationUri,
      body: request.toJson(),
      cancelToken: cancelToken,
    );
    return TextGenerationResponse.fromJson(res);
  }

  @override
  Future<TextGenerationAsyncResponse> generateAsyncText(
    TextGenerationRequest request, {
    ApiCancelToken? cancelToken,
  }) async {
    final res = await _client.post(
      textGenerationAsyncUri,
      body: request.toJson(),
      cancelToken: cancelToken,
    );
    return TextGenerationAsyncResponse.fromJson(res);
  }

  @override
  Future<EmbeddingResponse> getTextEmbedding(
    EmbeddingRequest request, {
    ApiCancelToken? cancelToken,
  }) async {
    final res = await _client.post(
      textEmbeddingUri,
      body: request.toJson(),
      cancelToken: cancelToken,
    );
    return EmbeddingResponse.fromJson(res);
  }

  @override
  Future<TokenizeResponse> tokenizeSummary(
    TextGenerationRequest request, {
    ApiCancelToken? cancelToken,
  }) async {
    final res = await _client.post(
      tokenizeTextUri,
      body: request.toJson(),
      cancelToken: cancelToken,
    );
    return TokenizeResponse.fromJson(res);
  }

  @override
  Future<TokenizeResponse> tokenizeText(
    TokenizeTextRequest request, {
    ApiCancelToken? cancelToken,
  }) async {
    final res = await _client.post(
      tokenizeCompletionUri,
      body: request.toJson(),
      cancelToken: cancelToken,
    );
    return TokenizeResponse.fromJson(res);
  }
}

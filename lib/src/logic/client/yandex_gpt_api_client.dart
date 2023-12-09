import 'package:http/http.dart' as http;
import 'package:yandex_gpt_rest_api/src/logic/api/yandex_gpt_api.dart';
import 'package:yandex_gpt_rest_api/src/logic/client/yandex_gpt_http_client.dart';
import 'package:yandex_gpt_rest_api/src/logic/helper/api_cancel_token.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/url_paths.dart';

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
  Future<TokenizeResponse> tokenizeCompletion(
    TextGenerationRequest request, {
    ApiCancelToken? cancelToken,
  }) async {
    final res = await _client.post(
      tokenizeCompletionUri,
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
      tokenizeTextUri,
      body: request.toJson(),
      cancelToken: cancelToken,
    );
    return TokenizeResponse.fromJson(res);
  }
}

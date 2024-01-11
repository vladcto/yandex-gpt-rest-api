import 'package:dio/dio.dart';
import 'package:yandex_gpt_rest_api/src/logic/api/yandex_gpt_api.dart';
import 'package:yandex_gpt_rest_api/src/logic/client/yandex_gpt_header_interceptor.dart';
import 'package:yandex_gpt_rest_api/src/logic/client/yandex_gpt_http_client.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/api_url.dart';

final class YandexGptApiClient implements YandexGptApi {
  final YandexGptHttpClient _client;
  final YandexGptHeaderInterceptor _headerInterceptor;

  YandexGptApiClient({
    required AuthToken token,
    String? catalog,
  }) : this.withDio(dio: Dio(), token: token, catalog: catalog);

  YandexGptApiClient.withOptions({
    required BaseOptions options,
    required AuthToken token,
    String? catalog,
  }) : this.withDio(
          dio: Dio()..options = options,
          token: token,
          catalog: catalog,
        );

  YandexGptApiClient.withDio({
    required Dio dio,
    required AuthToken token,
    String? catalog,
  })  : _client = YandexGptHttpClient(dio),
        _headerInterceptor = YandexGptHeaderInterceptor(
          catalog: catalog ?? "",
          token: token,
        ) {
    dio.interceptors.add(_headerInterceptor);
  }

  @override
  void changeToken(AuthToken token) {
    _headerInterceptor.changeToken(token);
  }

  @override
  Future<TextGenerationResponse> generateText(
    TextGenerationRequest request, {
    CancelToken? cancelToken,
  }) async {
    final res = await _client.post(
      ApiUrl.textGeneration,
      body: request.toJson(),
      cancelToken: cancelToken,
    );
    return TextGenerationResponse.fromJson(res);
  }

  @override
  Future<TextGenerationAsyncResponse> generateAsyncText(
    TextGenerationRequest request, {
    CancelToken? cancelToken,
  }) async {
    final res = await _client.post(
      ApiUrl.textGenerationAsync,
      body: request.toJson(),
      cancelToken: cancelToken,
    );
    return TextGenerationAsyncResponse.fromJson(res);
  }

  @override
  Future<TextGenerationAsyncResponse> getOperationTextGenerate(
      String operationId, {
        CancelToken? cancelToken,
      }) async {
    final res = await _client.post(
      ApiUrl.operation(operationId),
      cancelToken: cancelToken,
    );
    return TextGenerationAsyncResponse.fromJson(res);
  }

  @override
  Future<EmbeddingResponse> getTextEmbedding(
    EmbeddingRequest request, {
    CancelToken? cancelToken,
  }) async {
    final res = await _client.post(
      ApiUrl.textEmbedding,
      body: request.toJson(),
      cancelToken: cancelToken,
    );
    return EmbeddingResponse.fromJson(res);
  }

  @override
  Future<TokenizeResponse> tokenizeCompletion(
    TextGenerationRequest request, {
    CancelToken? cancelToken,
  }) async {
    final res = await _client.post(
      ApiUrl.tokenizeCompletion,
      body: request.toJson(),
      cancelToken: cancelToken,
    );
    return TokenizeResponse.fromJson(res);
  }

  @override
  Future<TokenizeResponse> tokenizeText(
    TokenizeTextRequest request, {
    CancelToken? cancelToken,
  }) async {
    final res = await _client.post(
      ApiUrl.tokenizeText,
      body: request.toJson(),
      cancelToken: cancelToken,
    );
    return TokenizeResponse.fromJson(res);
  }
}

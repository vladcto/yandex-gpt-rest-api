import 'package:dio/dio.dart';
import 'package:yandex_gpt_rest_api/src/logic/client/yandex_gpt_header_interceptor.dart';
import 'package:yandex_gpt_rest_api/src/logic/client/yandex_gpt_http_client.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/api_url.dart';

final class YandexGptApi {
  final YandexGptHttpClient _client;
  final YandexGptHeaderInterceptor _headerInterceptor;

  YandexGptApi({
    required AuthToken token,
    String? catalog,
  }) : this.withDio(dio: Dio(), token: token, catalog: catalog);

  YandexGptApi.withOptions({
    required BaseOptions options,
    required AuthToken token,
    String? catalog,
  }) : this.withDio(
          dio: Dio()..options = options,
          token: token,
          catalog: catalog,
        );

  YandexGptApi.withDio({
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

  void changeToken(AuthToken token) {
    _headerInterceptor.changeToken(token);
  }

  Future<TextGenerationResponse> generateText(
    TextGenerationRequest request, {
    CancelToken? cancelToken,
  }) async {
    final res = await _client.post(
      ApiUrl.textGeneration,
      body: request.toJson(),
      cancelToken: cancelToken,
    );
    return TextGenerationResponse.fromJson(
      res['result'] as Map<String, dynamic>,
    );
  }

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

  Future<TextGenerationAsyncResponse> getOperationTextGenerate(
    String operationId, {
    CancelToken? cancelToken,
  }) async {
    final res = await _client.get(
      ApiUrl.operation(operationId),
      cancelToken: cancelToken,
    );
    return TextGenerationAsyncResponse.fromJson(res);
  }

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

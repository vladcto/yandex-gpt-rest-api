import 'package:dio/dio.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';

abstract interface class YandexGptApi {
  Future<TextGenerationAsyncResponse> generateAsyncText(
    TextGenerationRequest request, {
    CancelToken? cancelToken,
  });

  Future<TextGenerationResponse> generateText(
    TextGenerationRequest request, {
    CancelToken? cancelToken,
  });

  Future<TokenizeResponse> tokenizeText(
    TokenizeTextRequest request, {
    CancelToken? cancelToken,
  });

  Future<TokenizeResponse> tokenizeCompletion(
    TextGenerationRequest request, {
    CancelToken? cancelToken,
  });

  Future<EmbeddingResponse> getTextEmbedding(
    EmbeddingRequest request, {
    CancelToken? cancelToken,
  });
}

import 'package:yandex_gpt_rest_sdk/src/logic/helper/api_cancel_token.dart';
import 'package:yandex_gpt_rest_sdk/src/models/models.dart';

abstract interface class YandexGptApi {
  Future<TextGenerationAsyncResponse> generateAsyncText(
    TextGenerationRequest request, {
    ApiCancelToken? cancelToken,
  });

  Future<TextGenerationResponse> generateText(
    TextGenerationRequest request, {
    ApiCancelToken? cancelToken,
  });

  Future<TokenizeResponse> tokenizeText(
    TokenizeTextRequest request, {
    ApiCancelToken? cancelToken,
  });

  Future<TokenizeResponse> tokenizeCompletion(
    TextGenerationRequest request, {
    ApiCancelToken? cancelToken,
  });

  Future<EmbeddingResponse> getTextEmbedding(
    EmbeddingRequest request, {
    ApiCancelToken? cancelToken,
  });
}

import 'package:yandex_gpt_rest_sdk/src/client/api_cancel_token.dart';
import 'package:yandex_gpt_rest_sdk/src/models/embeddings/embedding_request.dart';
import 'package:yandex_gpt_rest_sdk/src/models/embeddings/embedding_response.dart';
import 'package:yandex_gpt_rest_sdk/src/models/text_generation/async_response/text_generation_async_response.dart';
import 'package:yandex_gpt_rest_sdk/src/models/text_generation/request/text_generation_request.dart';
import 'package:yandex_gpt_rest_sdk/src/models/text_generation/sync_response/text_generation_response.dart';
import 'package:yandex_gpt_rest_sdk/src/models/tokenizer/tokenize_response.dart';
import 'package:yandex_gpt_rest_sdk/src/models/tokenizer/tokenize_text_request.dart';

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

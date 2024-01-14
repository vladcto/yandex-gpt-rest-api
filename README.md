# yandex_gpt_rest_api

[![Test CI](https://github.com/vladcto/yandex-gpt-rest-api/actions/workflows/test_with_coverage.yaml/badge.svg?branch=main&event=push)](https://github.com/vladcto/yandex-gpt-rest-api/actions/workflows/test_with_coverage.yaml)
[![codecov](https://codecov.io/gh/vladcto/yandex-gpt-rest-api/graph/badge.svg?token=747T4E5KE6)](https://codecov.io/gh/vladcto/yandex-gpt-rest-api)

## Creating YandexGptApi client
```dart
final api = YandexGptApi(
  token: AuthToken.api("your_token"),
  // Not necessary, by default using catalog ID of AuthToken Account.
  catalog: "catalog_id?",  
);
```

Now you can use the Foundation Models API.

## API capabilities

### Text Generation

#### Generate text

```dart
void main() async {
  final response = await api.generateText(
    TextGenerationRequest(
      model: GModel.yandexGpt('folder_id'),
      messages: const [
        Message.system("Some joke"),
        Message.user("Generate joke"),
      ],
    ),
  );
  print(response.alternatives.first.message);
  print(response.usage.totalTokens);
}
```

#### Generate async text

```dart
void main() async {
  final response = await api.generateAsyncText(
    TextGenerationRequest(
      model: GModel.yandexGpt('folder_id'),
      messages: const [
        Message.system("Some joke"),
        Message.user("Generate joke"),
      ],
    ),
  );
  print(response.done);
}
```

### Tokenize

#### Tokenize completion

```dart
void main() async {
  final response = await api.tokenizeCompletion(
    TextGenerationRequest(
      model: GModel.yandexGpt('folder_id'),
      messages: const [
        Message.system("Some joke"),
        Message.user("Generate joke"),
      ],
    ),
  );
  print(response.tokens.length);
}
```

#### Tokenize text

```dart
void main() async {
  final response = await api.tokenizeText(
    TokenizeTextRequest(
      model: GModel.yandexGpt('folder_id'),
      text: 'some_response_text',
    ),
  );
  print(response.tokens.length);
}
```

### Embeddings

```dart
void main() async {
  final response = await api.getTextEmbedding(
    EmbeddingRequest(
      model: VModel.documentation('folder_id'),
      text: 'Some text',
    ),
  );
  print(response.embedding);
}
```

## Handling errors

It is enough to catch an error of type ApiError.

```dart
try {
  await api.generateText(/*request*/);
} on ApiError catch (e) {
  // handle ApiErrors
} on DioException catch (e) {
  // Handle network errors
}
```

If you need information about the error (grpcCode for example):

```dart
try {
    await api.generateText(/*request*/);
} on DetailedApiError catch (e) {
  // Do some
} on ShortApiError catch (e) {
  // Do some
} on DioException catch (e) {
  // Handle network errors
}
```

## Closing requests

To cancel requests use **Dio** `CancelToken` by passing `YandexGptApi` requests with `cancelToken` param.

The handling cancellation is similar to the [example from the Dio doc](https://github.com/cfug/dio/blob/51d0bbb74298f40ef2f54d6109c2510c978f3771/example/lib/cancel_request.dart).
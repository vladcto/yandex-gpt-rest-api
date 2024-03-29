# YandexGPT API Client

[![Test CI](https://github.com/vladcto/yandex-gpt-rest-api/actions/workflows/test_with_coverage.yaml/badge.svg?branch=main&event=push)](https://github.com/vladcto/yandex-gpt-rest-api/actions/workflows/test_with_coverage.yaml)
[![codecov](https://codecov.io/gh/vladcto/yandex-gpt-rest-api/graph/badge.svg?token=747T4E5KE6)](https://codecov.io/gh/vladcto/yandex-gpt-rest-api)

Dart library for working with [YandexGPT API](https://cloud.yandex.ru/en/docs/yandexgpt/).

- [Getting started](#getting-started)
- [API capabilities](#api-capabilities)
- [Handling errors](#handling-errors)
- [Cancel requests](#cancel-requests)

## Getting started

Create `YandexGptApi` instance.

```dart

// For passing BaseOptions or Dio use other constructors.
final api = YandexGptApi(
  token: AuthToken.api("your_token"), // or AuthToken.iam
  // Not necessary, by default uses catalog from AuthToken account.
  catalog: "catalog_id?",
);
```

Now you can use the YandexGPT API.

## API calls

The names of methods `YandexGptApi` are same to the names of API methods.

Available API calls:

<details>
<summary>Text Generation</summary>

When generating large text with configured small `dio.options.receiveTimeout` a timeout error may occur.

### Generate sync text

```dart
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
```

### Generate async text

The `generateAsyncText` returns the [Operation object](https://cloud.yandex.com/en/docs/api-design-guide/concepts/operation).

For handling `Operation` you can use [getOperationTextGenerate](#fetch-async-generation-status).

```dart
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
```

### Fetch async generation status
```dart
final asyncText = await api.generateAsyncText(/*request*/);
final response = await api.getOperationTextGenerate(asyncText.id);
print(response.done);
```

</details>

<details>
<summary>Tokenize</summary>

### Tokenize completion

```dart
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
```

### Tokenize text

```dart
final response = await api.tokenizeText(
  TokenizeTextRequest(
    model: GModel.yandexGpt('folder_id'),
    text: 'some_response_text',
  ),
);
print(response.tokens.length);
```
</details>

<details>
<summary>Embeddings</summary>

### Text embedding

```dart
final response = await api.getTextEmbedding(
  EmbeddingRequest(
    model: VModel.documentation('folder_id'),
    text: 'Some text',
  ),
);
print(response.embedding);
```
</details>

## Handling errors

It is enough to catch an error of type `ApiError`.

```dart
try {
  await api.generateText(/*request*/);
} on ApiError catch (e) {
  // Handle YandexGPT API errors
} on DioException catch (e) {
  // Handle network errors
}
```

If you need information about the error:

```dart
try {
  await api.generateText(/*request*/);
} on DetailedApiError catch (e) {
  // Handle DetailedApiError
} on ShortApiError catch (e) {
  // Handle ShortApiError
} on DioException catch (e) {
  // Handle network errors
}
```

## Cancel requests

To cancel requests use Dio `CancelToken` by passing API requests with `cancelToken` param.

The handling cancellation is similar to
the [example from the Dio doc](https://github.com/cfug/dio/blob/51d0bbb74298f40ef2f54d6109c2510c978f3771/example/lib/cancel_request.dart).

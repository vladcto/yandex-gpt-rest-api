# yandex_gpt_rest_api

[![Test CI](https://github.com/vladcto/yandex-gpt-rest-api/actions/workflows/test_ci.yaml/badge.svg?branch=main&event=push)](https://github.com/vladcto/yandex-gpt-rest-api/actions/workflows/test_ci.yaml)
[![codecov](https://codecov.io/gh/vladcto/yandex-gpt-rest-api/graph/badge.svg?token=747T4E5KE6)](https://codecov.io/gh/vladcto/yandex-gpt-rest-api)

## **UNDER WORK**

The signature of the methods may change.

## Getting started

Create `YandexGptApi` instance.

```dart

final api = YandexGptApiClient(
  token: "your_token",
  catalog: "your_catalog_id", // Not necessary
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
      modelUri: GModel.yandexGpt('folder_id'),
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

**UNDER_WORK**

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
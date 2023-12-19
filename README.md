# yandex_gpt_rest_api

<p>
    <a href="https://codecov.io/gh/vladcto/yandex-gpt-rest-api" > 
        <img src="https://codecov.io/gh/vladcto/yandex-gpt-rest-api/graph/badge.svg?token=747T4E5KE6" alt="coverage"/>
    </a>
    <img src="https://github.com/vladcto/yandex-gpt-rest-api/actions/workflows/dart_test.yaml/badge.svg?branch=code-coverage-ci">
</p>

Library for communicating with the Yandex Foundation Models API.

## **UNDER WORK**

Receiving data from the API is now working.

Asynchronous generation does not work.

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
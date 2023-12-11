# yandex_gpt_rest_api

Library for communicating with the Yandex Foundation Models API.

## **UNDER WORK**

Receiving data from the API is now working.

Asynchronous generation and receipt does not work. 

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

```dart
final response = await api.generateText(
  TextGenerationRequest(
    modelUri: GModels.yandexGpt('folder_id'),
    messages: const [
      Message(
        role: Role.system,
        text: "You joke generating app.",
      ),
      Message(
        role: Role.user,
        text: "Generate some funny joke pls",
      ),
    ],
  ),
);
final generatedMessage = response.alternatives.first;
print(generatedMessage.message.text);
```
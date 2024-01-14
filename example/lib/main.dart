import 'dart:async';

import 'package:dio/dio.dart';
import 'package:yandex_gpt_rest_api/yandex_gpt_rest_api.dart';

final token = AuthToken.iam("key-here");
final catalog = 'catalog-here';

final api = YandexGptApi(token: token, catalog: catalog);

Future<void> main() async {
  await generateText();
  // await generateAsyncText();
  await tokenizeText();
  await tokenizeTextResponse();
  await embedding();
  await handleErrors();
  await closeRequest();
}

Future<void> generateText() async {
  final response = await api.generateText(
    TextGenerationRequest(
      model: GModel.yandexGpt(catalog),
      messages: [Message.user('Say some funny joke')],
    ),
  );

  print("Used tokens: ${response.usage.totalTokens}");
  print("Joke status: ${response.alternatives.first.status}");
  print("     message: ${response.alternatives.first.message.text}");
  print('');
}

Future<void> generateAsyncText() async {
  final request = TextGenerationRequest(
    model: GModel.yandexGptLight(catalog),
    messages: [Message.user("Generate a short story")],
  );

  final id = (await api.generateAsyncText(request)).id;
  print("ID Operation: $id");
  await Future.delayed(Duration(seconds: 10));
  final response = await api.getOperationTextGenerate(id);

  if (!response.done) {
    print('Operation not done');
  } else if (response.result != null) {
    print('Operation result:');
    print(response.result);
  } else {
    print('Operation error:');
    print(response.error);
  }
  print('');
}

Future<void> tokenizeText() async {
  final response = await api.tokenizeText(
    TokenizeTextRequest(
      model: GModel.yandexGptLight(catalog),
      text: "Very. Long text \n",
    ),
  );

  print("Tokens count: ${response.tokens.length}");
  print("Tokens: ${response.tokens}");
  print('');
}

Future<void> tokenizeTextResponse() async {
  final response = await api.tokenizeCompletion(
    TextGenerationRequest(
      model: GModel.yandexGpt(catalog),
      messages: [Message.assistant('Some funny joke')],
    ),
  );

  print("Tokens count: ${response.tokens.length}");
  print("Tokens: ${response.tokens}");
  print('');
}

Future<void> embedding() async {
  final response = await api.getTextEmbedding(
    EmbeddingRequest(
      model: VModel.documentation(catalog),
      text: "Very. Long text \n",
    ),
  );

  print("Embedding: ${response.embedding}");
  print('');
}

Future<void> handleErrors() async {
  final errorClient = YandexGptApi(token: AuthToken.apiKey('sus'));

  try {
    await errorClient.generateText(
      TextGenerationRequest(model: GModel.yandexGpt(''), messages: []),
    );
  } on ApiError catch (e) {
    final error = switch (e) {
      DetailedApiError(httpCode: final httpCode) => httpCode,
      ShortApiError(grpcCode: final grpcCode) => grpcCode,
    };
    print("Error($error) message: ${e.message}");
  } on DioException catch (e) {
    print("Network errors: $e");
  }
  print('');
}

Future<void> closeRequest() async {
  final errorClient = YandexGptApi(token: AuthToken.apiKey('sus'));
  final cancelToken = CancelToken();

  errorClient
      .generateText(
        TextGenerationRequest(model: GModel.yandexGpt(''), messages: []),
        cancelToken: cancelToken,
      )
      .then(
        (value) => throw Exception("Never gonna get value"),
        onError: (e) => print("Canceled with ${e.runtimeType}\n"),
      );
  cancelToken.cancel();
}

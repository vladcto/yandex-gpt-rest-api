import 'dart:convert';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:yandex_gpt_rest_api/src/logic/api/yandex_gpt_api.dart';
import 'package:yandex_gpt_rest_api/src/logic/client/yandex_gpt_api_client.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/url_paths.dart';
import 'yandex_gpt_http_client_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('YandexGptApiClient', () {
    late YandexGptApi apiClient;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      apiClient = YandexGptApiClient.withHttpClient(
        client: mockClient,
        token: 'your_token',
        catalog: 'your_catalog',
      );
    });

    group("Successful responses convert", () {
      test("Created HTTP client", () {
        final api = YandexGptApiClient(token: "token");
      });

      test("generateText", () async {
        const json = {
          "result": {
            "alternatives": [
              {
                "message": {
                  "role": "assistant",
                  "text": "sus",
                },
                "status": "ALTERNATIVE_STATUS_FINAL",
              }
            ],
            "usage": {
              "inputTextTokens": "13",
              "completionTokens": "4",
              "totalTokens": "17",
            },
            "modelVersion": "08.12.2023",
          },
        };
        _mockClientResponse(
          client: mockClient,
          uri: textGenerationUri,
          json: json,
        );

        final result = await apiClient.generateText(
          const TextGenerationRequest(
            modelUri: '',
            messages: [],
          ),
        );

        expect(result.modelVersion, "08.12.2023");
        expect(
          result.usage.toString(),
          const ModelUsage(
            inputTextTokens: 13,
            completionTokens: 4,
            totalTokens: 17,
          ).toString(),
        );
        expect(result.alternatives.length, 1);
        expect(
          result.alternatives.first.toString(),
          const ResultMessage(
            message: Message(
              role: Role.assistant,
              text: "sus",
            ),
            status: ResultMessageStatus.finalDone,
          ).toString(),
        );
      });

      test("asyncGenerateText", () async {
        final json = {
          "id": "sus",
          "description": "amogus",
          "createdAt": "at",
          "createdBy": "by",
          "modifiedAt": "modified",
          "metadata": "metadata",
          "response": "response",
        };

        _mockClientResponse(
          client: mockClient,
          uri: textGenerationAsyncUri,
          json: json,
        );

        final result = await apiClient.generateAsyncText(
          const TextGenerationRequest(
            modelUri: '',
            messages: [],
          ),
        );

        expect(result.id, "sus");
        expect(result.description, "amogus");
        expect(result.createdBy, "by");
        expect(result.createdAt, "at");
        expect(result.modifiedAt, "modified");
        expect(result.metadata, "metadata");
        expect(result.done, true);
      });

      test("getTextEmbedding", () async {
        const json = {
          "embedding": [
            -0.2,
            0.1,
          ],
          "numTokens": "5",
          "modelVersion": "06.12.2023",
        };
        _mockClientResponse(
          client: mockClient,
          uri: textEmbeddingUri,
          json: json,
        );

        final res = await apiClient.getTextEmbedding(
          const EmbeddingRequest(modelUri: '', text: ''),
        );
        expect(res.modelVersion, "06.12.2023");
        expect(res.numTokens, 5);
        expect(res.embedding, [-0.2, 0.1]);
      });

      test("tokenizeCompletion", () async {
        const json = {
          "tokens": [
            {
              "id": "0",
              "text": "amo",
              "special": true,
            },
            {
              "id": "2",
              "text": "gus",
              "special": false,
            },
          ],
          "modelVersion": "08.12.2023",
        };
        _mockClientResponse(
          client: mockClient,
          uri: tokenizeCompletionUri,
          json: json,
        );

        final res = await apiClient.tokenizeCompletion(
          const TextGenerationRequest(
            modelUri: '',
            messages: [
              Message(role: Role.system, text: ''),
            ],
          ),
        );
        expect(res.modelVersion, "08.12.2023");
        expect(res.tokens.length, 2);
        expect(
          res.tokens.first.toString(),
          Token(id: "0", text: "amo", special: true).toString(),
        );
        expect(
          res.tokens[1].toString(),
          Token(id: "2", text: "gus", special: false).toString(),
        );
      });

      test("tokenizeText", () async {
        const json = {
          "tokens": [
            {
              "id": "0",
              "text": "amo",
              "special": true,
            },
            {
              "id": "2",
              "text": "gus",
              "special": false,
            },
          ],
          "modelVersion": "08.12.2023",
        };
        _mockClientResponse(
          client: mockClient,
          uri: tokenizeTextUri,
          json: json,
        );

        final res = await apiClient.tokenizeText(
          const TokenizeTextRequest(modelUri: '', text: ''),
        );
        expect(res.modelVersion, "08.12.2023");
        expect(res.tokens.length, 2);
        expect(
          res.tokens.first.toString(),
          Token(id: "0", text: "amo", special: true).toString(),
        );
        expect(
          res.tokens[1].toString(),
          Token(id: "2", text: "gus", special: false).toString(),
        );
      });
    });
  });
}

void _mockClientResponse({
  required MockClient client,
  required Uri uri,
  required Map<String, dynamic> json,
}) {
  final mockResponse = Response(
    jsonEncode(json),
    200,
    headers: {'content-type': 'application/json'},
  );
  when(
    client.post(
      uri,
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    ),
  ).thenAnswer((_) async => mockResponse);
}

import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';
import 'package:yandex_gpt_rest_api/src/logic/client/yandex_gpt_api_client.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/api_url.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/headers.dart';

void main() {
  group('YandexGptApiClient', () {
    late Dio dio;
    late YandexGptApiClient apiClient;
    late DioAdapter adapter;
    const token = AuthToken.iam("token");

    setUp(() {
      dio = Dio();
      apiClient = YandexGptApiClient.withDio(
        dio: dio,
        token: token,
        catalog: 'your_catalog',
      );
      adapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
    });

    group("Creation", () {
      test("Creation default", () {
        YandexGptApiClient(token: const AuthToken.apiKey('key'));
      });

      test("Creation with base options", () {
        YandexGptApiClient.withOptions(
          options: BaseOptions(),
          token: const AuthToken.apiKey('key'),
        );
      });
    });

    group("Successful responses convert", () {
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
          adapter: adapter,
          url: ApiUrl.textGeneration,
          json: json,
        );

        final result = await apiClient.generateText(
          const TextGenerationRequest(
            model: GModel.raw(''),
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
        // TODO: Normal response and error JSON
        final json = {
          "id": "sus",
          "description": "amogus",
          "createdAt": "at",
          "createdBy": "by",
          "modifiedAt": "modified",
          "metadata": "metadata",
        };

        _mockClientResponse(
          adapter: adapter,
          url: ApiUrl.textGenerationAsync,
          json: json,
        );

        final result = await apiClient.generateAsyncText(
          const TextGenerationRequest(
            model: GModel.raw(''),
            messages: [],
          ),
        );

        expect(result.id, "sus");
        expect(result.description, "amogus");
        expect(result.createdBy, "by");
        expect(result.createdAt, "at");
        expect(result.modifiedAt, "modified");
        expect(result.metadata, "metadata");
        expect(result.done, false);
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
          adapter: adapter,
          url: ApiUrl.textEmbedding,
          json: json,
        );

        final res = await apiClient.getTextEmbedding(
          const EmbeddingRequest(model: VModel.raw(''), text: ''),
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
          adapter: adapter,
          url: ApiUrl.tokenizeCompletion,
          json: json,
        );

        final res = await apiClient.tokenizeCompletion(
          const TextGenerationRequest(
            model: GModel.raw(''),
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
          adapter: adapter,
          url: ApiUrl.tokenizeText,
          json: json,
        );

        final res = await apiClient.tokenizeText(
          const TokenizeTextRequest(model: GModel.raw(''), text: ''),
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

    group("Client interface", () {
      late final DioAdapter headerMatcherAdapter;

      setUp(() {
        headerMatcherAdapter = DioAdapter(
          dio: dio,
          matcher: _HeaderMatcherAdapter(),
        );
      });

      test("Success change token", () async {
        apiClient.changeToken(const AuthToken.iam('iam'));
        apiClient.changeToken(const AuthToken.apiKey('api-key'));
        const request = TokenizeTextRequest(
          model: GModel.yandexGpt(''),
          text: '',
        );
        const response = {
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

        headerMatcherAdapter.onPost(
          ApiUrl.tokenizeText,
          (server) {
            server.reply(200, response);
          },
          headers: {
            authHeaderName: const AuthToken.apiKey('api-key').toString(),
          },
        );

        await expectLater(
          apiClient.tokenizeText(request),
          completes,
        );
      });
    });
  });
}

void _mockClientResponse({
  required DioAdapter adapter,
  required String url,
  required Map<String, dynamic> json,
}) {
  adapter.onGet(url, (server) {
    server.reply(200, json);
  });
}

class _HeaderMatcherAdapter extends HttpRequestMatcher {
  @override
  bool matches(RequestOptions ongoingRequest, Request matcher) {
    return matcher.headers?.entries.every(
          (element) {
            return ongoingRequest.headers[element.key] == element.value;
          },
        ) ??
        true;
  }
}

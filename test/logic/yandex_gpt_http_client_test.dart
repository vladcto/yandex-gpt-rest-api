import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';
import 'package:yandex_gpt_rest_api/src/logic/client/yandex_gpt_http_client.dart';
import 'package:yandex_gpt_rest_api/src/models/errors/api_error.dart';

const url = "";

void main() {
  group('YandexGptHttpClient', () {
    late YandexGptHttpClient httpClient;
    late Dio dio;
    late DioAdapter adapter;

    setUp(() {
      dio = Dio();
      adapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
      httpClient = YandexGptHttpClient(dio);
    });

    test('Handle successful POST response', () async {
      adapter.onPost(
        url,
        (server) => server.reply(200, {'key': 'value'}),
      );

      final result = await httpClient.post(url);

      expect(result, equals({'key': 'value'}));
    });

    test('Handle successful GET response', () async {
      adapter.onGet(
        url,
        (server) => server.reply(200, {'key': 'value'}),
      );

      final result = await httpClient.get(url);

      expect(result, equals({'key': 'value'}));
    });

    test('Do not handle DioException', () async {
      adapter.onPost(url, (server) {
        server.reply(400, {});
      });

      await expectLater(
        httpClient.post(url),
        throwsA(isA<DioException>()),
      );
    });

    test('Handle plain text error format', () async {
      adapter.onPost(url, (server) {
        server.reply(400, "some error that i didnt expect");
      });

      await expectLater(
        httpClient.post(url),
        throwsA(isA<DioException>()),
      );
    });

    test('Handle unknown non-200 response format', () async {
      adapter.onPost(url, (server) {
        server.reply(400, {});
      });

      await expectLater(
        httpClient.post(url),
        throwsA(isA<DioException>()),
      );
    });

    group('Handle ContractApiError', () {
      test('Handle DetailedApiError', () {
        final json = {
          "error": {
            "grpcCode": 3,
            "httpCode": 400,
            "message":
                "Error in session internal_id=e70ea36e-ac45168c-6fc07c0-c3bcc3f6&request_id=221522d7-7df0-4d31-bab7-6a7e77abd016&client_request_id=undefined&folder_id=b1gv4d5ihg9cg29jicr4: invalid message role 'some_shit'",
            "httpStatus": "Bad Request",
            "details": [],
          },
        };
        adapter.onPost(url, (server) {
          server.reply(400, json);
        });

        expectLater(
          httpClient.post(url),
          throwsA(isA<DetailedApiError>()),
        );
      });

      test("Handle ShortApiError", () {
        final json = {
          "error": "invalid character '}' looking for beginning of value",
          "code": 3,
          "message": "invalid character '}' looking for beginning of value",
          "details": [],
        };
        adapter.onPost(url, (server) {
          server.reply(400, json);
        });

        expectLater(
          httpClient.post(url),
          throwsA(isA<ShortApiError>()),
        );
      });
    });

    test("Throws error on cancel", () async {
      final token = CancelToken();
      adapter.onPost(url, (server) {
        server.reply(200, "good", delay: const Duration(milliseconds: 1));
      });

      Future(() => token.cancel());
      await expectLater(
        httpClient.post(url, cancelToken: token),
        throwsA(isA<DioException>()),
      );
      expect(token.isCancelled, true);
      token.cancel('Check is token not allocated anywhere');
    });
  });
}

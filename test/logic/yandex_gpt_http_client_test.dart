import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:yandex_gpt_rest_api/src/logic/client/yandex_gpt_http_client.dart';
import 'package:yandex_gpt_rest_api/src/logic/helper/api_cancel_token.dart';
import 'package:yandex_gpt_rest_api/src/models/errors/api_error.dart';
import 'yandex_gpt_http_client_test.mocks.dart';

final uri = Uri();

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('YandexGptHttpClient', () {
    late YandexGptHttpClient httpClient;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      httpClient = YandexGptHttpClient(
        client: mockClient,
        token: 'your_token',
        catalog: 'your_catalog',
      );
    });

    test('Handle successful response', () async {
      final mockResponse = Response(
        jsonEncode({'key': 'value'}),
        200,
        headers: {'content-type': 'application/json'},
      );
      when(
        mockClient.post(
          uri,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => mockResponse);

      final result = await httpClient.post(uri);

      expect(result, equals({'key': 'value'}));
    });

    test('Do not handle ClientException', () async {
      when(
        mockClient.post(
          uri,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => throw ClientException('Client Exception'));

      await expectLater(
        httpClient.post(uri),
        throwsA(isA<ClientException>()),
      );
    });

    test('Do not handle HttpException', () async {
      when(
        mockClient.post(
          uri,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => throw const HttpException('HTTP Exception'));

      await expectLater(
        httpClient.post(uri),
        throwsA(isA<HttpException>()),
      );
    });

    test('Handle unknown non-200 response format', () async {
      final mockResponse = Response(
        jsonEncode({'error': 'Some error message'}),
        404,
        headers: {'content-type': 'application/json'},
      );
      when(
        mockClient.post(
          uri,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => mockResponse);

      await expectLater(
        httpClient.post(uri),
        throwsA(isA<ShortApiError>()),
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
        final mockResponse = Response(
          jsonEncode(json),
          400,
          headers: {'content-type': 'application/json'},
        );
        when(
          mockClient.post(
            uri,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        expectLater(
          httpClient.post(uri),
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
        final mockResponse = Response(
          jsonEncode(json),
          400,
          headers: {'content-type': 'application/json'},
        );
        when(
          mockClient.post(
            uri,
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => mockResponse);

        expectLater(
          httpClient.post(uri),
          throwsA(isA<ShortApiError>()),
        );
      });
    });

    test("Throws error on cancel", () async {
      final token = ApiCancelToken();
      final mockResponse = Response("", 200);
      when(
        mockClient.post(
          uri,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => await Future.delayed(
          const Duration(seconds: 2),
          () => mockResponse,
        ),
      );

      Future(() => token.close());
      await expectLater(
        httpClient.post(uri, cancelToken: token),
        throwsA(isA<CanceledError>()),
      );
    });

    test("Don`t throws error on post-cancel", () async {
      final token = ApiCancelToken();
      final mockResponse = Response("{}", 200);
      when(
        mockClient.post(
          uri,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => mockResponse,
      );

      await expectLater(
        httpClient.post(uri, cancelToken: token),
        completes,
      );
      await expectLater(Future(() => token.close()), completes);
    });
  });
}

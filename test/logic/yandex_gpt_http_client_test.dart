import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:yandex_gpt_rest_api/src/logic/client/yandex_gpt_http_client.dart';
import 'package:yandex_gpt_rest_api/src/models/errors/api_error.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'yandex_gpt_http_client_test.mocks.dart';

final uri = Uri();
const url = "";

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  group('YandexGptHttpClient', () {
    late MockDio mockDio;
    late YandexGptHttpClient httpClientWithMock;
    late YandexGptHttpClient httpClient;
    late Dio dio;
    late DioAdapter adapter;

    setUp(() {
      mockDio = MockDio();
      dio = Dio();
      adapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());

      httpClient = YandexGptHttpClient(dio);
      httpClientWithMock = YandexGptHttpClient(mockDio);
    });

    test('Handle successful response', () async {
      adapter.onPost(
        url,
        (server) => server.reply(200, {'key': 'value'}),
      );

      final result = await httpClient.post(url);

      expect(result, equals({'key': 'value'}));
    });
    //
    // test('Do not handle ClientException', () async {
    //   when(
    //     mockClient.post(
    //       uri,
    //       headers: anyNamed('headers'),
    //       body: anyNamed('body'),
    //     ),
    //   ).thenAnswer((_) async => throw ClientException('Client Exception'));
    //
    //   await expectLater(
    //     httpClient.post(uri),
    //     throwsA(isA<ClientException>()),
    //   );
    // });
    //
    // test('Do not handle HttpException', () async {
    //   when(
    //     mockClient.post(
    //       uri,
    //       headers: anyNamed('headers'),
    //       body: anyNamed('body'),
    //     ),
    //   ).thenAnswer((_) async => throw const HttpException('HTTP Exception'));
    //
    //   await expectLater(
    //     httpClient.post(uri),
    //     throwsA(isA<HttpException>()),
    //   );
    // });
    //
    // test('Handle unknown non-200 response format', () async {
    //   final mockResponse = Response(
    //     jsonEncode({'error': 'Some error message'}),
    //     404,
    //     headers: {'content-type': 'application/json'},
    //   );
    //   when(
    //     mockClient.post(
    //       uri,
    //       headers: anyNamed('headers'),
    //       body: anyNamed('body'),
    //     ),
    //   ).thenAnswer((_) async => mockResponse);
    //
    //   await expectLater(
    //     httpClient.post(uri),
    //     throwsA(isA<ShortApiError>()),
    //   );
    // });
    //
    // group('Handle ContractApiError', () {
    //   test('Handle DetailedApiError', () {
    //     final json = {
    //       "error": {
    //         "grpcCode": 3,
    //         "httpCode": 400,
    //         "message":
    //             "Error in session internal_id=e70ea36e-ac45168c-6fc07c0-c3bcc3f6&request_id=221522d7-7df0-4d31-bab7-6a7e77abd016&client_request_id=undefined&folder_id=b1gv4d5ihg9cg29jicr4: invalid message role 'some_shit'",
    //         "httpStatus": "Bad Request",
    //         "details": [],
    //       },
    //     };
    //     final mockResponse = Response(
    //       jsonEncode(json),
    //       400,
    //       headers: {'content-type': 'application/json'},
    //     );
    //     when(
    //       mockClient.post(
    //         uri,
    //         headers: anyNamed('headers'),
    //         body: anyNamed('body'),
    //       ),
    //     ).thenAnswer((_) async => mockResponse);
    //
    //     expectLater(
    //       httpClient.post(uri),
    //       throwsA(isA<DetailedApiError>()),
    //     );
    //   });
    //
    //   test("Handle ShortApiError", () {
    //     final json = {
    //       "error": "invalid character '}' looking for beginning of value",
    //       "code": 3,
    //       "message": "invalid character '}' looking for beginning of value",
    //       "details": [],
    //     };
    //     final mockResponse = Response(
    //       jsonEncode(json),
    //       400,
    //       headers: {'content-type': 'application/json'},
    //     );
    //     when(
    //       mockClient.post(
    //         uri,
    //         headers: anyNamed('headers'),
    //         body: anyNamed('body'),
    //       ),
    //     ).thenAnswer((_) async => mockResponse);
    //
    //     expectLater(
    //       httpClient.post(uri),
    //       throwsA(isA<ShortApiError>()),
    //     );
    //   });
    // });
    //
    // test("Throws error on cancel", () async {
    //   final token = ApiCancelToken();
    //   final mockResponse = Response("", 200);
    //   when(
    //     mockClient.post(
    //       uri,
    //       headers: anyNamed('headers'),
    //       body: anyNamed('body'),
    //     ),
    //   ).thenAnswer(
    //     (_) async => await Future.delayed(
    //       const Duration(seconds: 2),
    //       () => mockResponse,
    //     ),
    //   );
    //
    //   Future(() => token.close());
    //   await expectLater(
    //     httpClient.post(uri, cancelToken: token),
    //     throwsA(isA<CanceledError>()),
    //   );
    // });
    //
    // test("Don`t throws error on post-cancel", () async {
    //   final token = ApiCancelToken();
    //   final mockResponse = Response("{}", 200);
    //   when(
    //     mockClient.post(
    //       uri,
    //       headers: anyNamed('headers'),
    //       body: anyNamed('body'),
    //     ),
    //   ).thenAnswer(
    //     (_) async => mockResponse,
    //   );
    //
    //   await expectLater(
    //     httpClient.post(uri, cancelToken: token),
    //     completes,
    //   );
    //   await expectLater(Future(() => token.close()), completes);
    // });
  });
}

import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:yandex_gpt_rest_api/src/logic/client/yandex_gpt_header_interceptor.dart';
import 'package:yandex_gpt_rest_api/src/models/auth/auth_token.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/headers.dart';

import 'yandex_gpt_interceptor_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RequestInterceptorHandler>()])
void main() {
  group("YandexGptHeaderInterceptor", () {
    late MockRequestInterceptorHandler requestInterceptorHandler;

    setUp(() {
      requestInterceptorHandler = MockRequestInterceptorHandler();
    });

    test('Handle response', () {
      final interceptor = YandexGptHeaderInterceptor(
        catalog: "catalog",
        token: const AuthToken.iam('iam'),
      );

      interceptor.onRequest(RequestOptions(), requestInterceptorHandler);
      verify(requestInterceptorHandler.next(any));
    });

    test('Send all headers', () {
      final interceptor = YandexGptHeaderInterceptor(
        catalog: "catalog",
        token: const AuthToken.iam('iam'),
      );

      interceptor.onRequest(RequestOptions(), requestInterceptorHandler);
      final sent = verify(requestInterceptorHandler.next(captureAny))
          .captured
          .first as RequestOptions;

      expect(sent.headers, containsPair(catalogIdHeaderName, 'catalog'));
      expect(
        sent.headers,
        containsPair(authHeaderName, const AuthToken.iam('iam').value),
      );
    });

    test('Change token', () {
      final interceptor = YandexGptHeaderInterceptor(
        catalog: "catalog",
        token: const AuthToken.iam('iam'),
      );

      interceptor.changeToken(const AuthToken.apiKey('key'));
      interceptor.onRequest(RequestOptions(), requestInterceptorHandler);
      final afterChange = verify(requestInterceptorHandler.next(captureAny))
          .captured
          .first as RequestOptions;

      expect(
        afterChange.headers,
        containsPair(authHeaderName, const AuthToken.apiKey('key').value),
      );
    });
  });
}

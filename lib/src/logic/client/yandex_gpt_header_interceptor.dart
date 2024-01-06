import 'package:dio/dio.dart';
import 'package:yandex_gpt_rest_api/src/models/auth/auth_token.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/headers.dart';

class YandexGptHeaderInterceptor extends Interceptor {
  final String _catalog;
  AuthToken _token;

  YandexGptHeaderInterceptor({
    required String catalog,
    required AuthToken token,
  })  : _catalog = catalog,
        _token = token;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      authHeaderName: _token.value,
      catalogIdHeaderName: _catalog,
    });
    handler.next(options);
  }

  void changeToken(AuthToken token) {
    _token = token;
  }
}

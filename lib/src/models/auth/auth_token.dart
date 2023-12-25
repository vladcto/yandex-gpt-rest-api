final class AuthToken {
  final String value;

  const AuthToken.iam(String iamToken) : value = 'Bearer $iamToken';

  const AuthToken.apiKey(String key) : value = 'Api-Key $key';
}

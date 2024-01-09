final class AuthToken {
  final String _value;

  const AuthToken.iam(String iamToken) : _value = 'Bearer $iamToken';

  const AuthToken.apiKey(String key) : _value = 'Api-Key $key';

  @override
  String toString() => _value;
}

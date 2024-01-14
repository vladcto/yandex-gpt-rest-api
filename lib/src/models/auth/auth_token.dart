/// Account authentication token in YandexGPT API.
final class AuthToken {
  final String _value;

  /// IAM Token is more secure, but requires you to request it every 12 hours.
  const AuthToken.iam(String iamToken) : _value = 'Bearer $iamToken';

  /// API key do not expire, so this authentication method is simpler but less secure.
  const AuthToken.apiKey(String key) : _value = 'Api-Key $key';

  /// Returns a string for authentication.
  @override
  String toString() => _value;
}

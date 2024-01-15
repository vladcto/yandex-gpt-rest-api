/// Account authentication token in YandexGPT API.
final class AuthToken {
  final String _value;

  /// IAM token is more secure, but requires you to request it every 12 hours.
  const AuthToken.iam(String iamToken) : _value = 'Bearer $iamToken';

  /// API key do not expire, so this authentication method is simpler but less secure.
  const AuthToken.apiKey(String apiKey) : _value = 'Api-Key $apiKey';

  /// Returns a string for authentication.
  @override
  String toString() => _value;
}

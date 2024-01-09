import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/auth/auth_token.dart';

void main() {
  group("AuthToken model", () {
    test("Iam token creation", () {
      const token = AuthToken.iam("iam-token");
      expect(token.toString(), 'Bearer iam-token');
    });

    test("Api key creation", () {
      const token = AuthToken.apiKey('api-key');
      expect(token.toString(), 'Api-Key api-key');
    });
  });
}

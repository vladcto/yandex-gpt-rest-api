import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';

void main() {
  group("Token model", () {
    test("fromJSON", () {
      final json = {
        "id": "0",
        "text": "<s>",
        "special": true,
      };

      final converted = Token.fromJson(json);
      expect(converted.id, "0");
      expect(converted.text, "<s>");
      expect(converted.special, true);
    });
  });
}

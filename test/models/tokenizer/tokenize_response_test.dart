import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';

void main() {
  group("TokenizeResponse model", () {
    test("fromJson", () {
      final tokens = [
        Token(id: "0", text: "<s>", special: true),
        Token(id: "16861", text: "User", special: false),
      ];
      final json = {
        "tokens": [
          {
            "id": "0",
            "text": "<s>",
            "special": true,
          },
          {
            "id": "16861",
            "text": "User",
            "special": false,
          },
        ],
        "modelVersion": "08.12.2023",
      };

      final converted = TokenizeResponse.fromJson(json);
      expect(converted.modelVersion, "08.12.2023");
      expect(
        converted.tokens.map((e) => e.toString()).toList(),
        equals(tokens.map((e) => e.toString()).toList()),
      );
    });
  });
}

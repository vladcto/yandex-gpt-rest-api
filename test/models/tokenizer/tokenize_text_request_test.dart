import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';

void main() {
  group("TokenizeTextRequest model", () {
    test("toJson", () {
      const request = TokenizeTextRequest(
        modelUri: "some_uri",
        text: "Some text",
      );

      final json = request.toJson();
      expect(json['modelUri'], 'some_uri');
      expect(json['text'], 'Some text');
    });
  });
}

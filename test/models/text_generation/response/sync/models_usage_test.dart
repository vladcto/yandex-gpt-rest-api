import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';

void main() {
  group("ModelUsage model", () {
    test("fromJson valid", () {
      final json = {
        "inputTextTokens": "12",
        "completionTokens": "4",
        "totalTokens": "16",
      };

      final converted = ModelUsage.fromJson(json);
      expect(converted.inputTextTokens, 12);
      expect(converted.completionTokens, 4);
      expect(converted.totalTokens, 16);
    });
  });
}

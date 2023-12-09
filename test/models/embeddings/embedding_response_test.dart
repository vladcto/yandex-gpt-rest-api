import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';

void main() {
  group("EmbeddingResponse model", () {
    test("fromJson", () {
      final json = {
        "embedding": [
          -0.1,
          -0.21,
          0.5,
        ],
        "numTokens": "5",
        "modelVersion": "06.12.2023",
      };

      final converted = EmbeddingResponse.fromJson(json);
      expect(converted.embedding, equals([-0.1, -0.21, 0.5]));
      expect(converted.numTokens, 5);
      expect(converted.modelVersion, '06.12.2023');
    });
  });
}

import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';

void main() {
  group("EmbeddingResponse model", () {
    test("toString", () {
      const response = EmbeddingResponse(
        embedding: [0.2, -0.2],
        numTokens: 12,
        modelVersion: "19.12.2002",
      );
      expect(response.toString(), isA<String>());
    });

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

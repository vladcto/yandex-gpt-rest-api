import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';

void main() {
  group("TextGenerationAsyncResponse", () {
    test("fromJson with success", () {
      final json = {
        "id": "sus",
        "description": "amogus",
        "createdAt": "at",
        "createdBy": "by",
        "modifiedAt": "modified",
        "metadata": "metadata",
      };

      final response = TextGenerationAsyncResponse.fromJson(json);

      expect(response.id, "sus");
      expect(response.description, "amogus");
      expect(response.createdAt, "at");
      expect(response.createdBy, "by");
      expect(response.modifiedAt, "modified");
      expect(response.metadata, "metadata");
      expect(response.done, false);
    });

    test("fromJson with error", () {
      final json = {
        "id": "sus",
        "description": "amogus",
        "createdAt": "at",
        "createdBy": "by",
        "modifiedAt": "modified",
        "metadata": "metadata",
        "error": {
          "code": 1,
          "message": "message",
          "details": ["detail"],
        },
      };

      final response = TextGenerationAsyncResponse.fromJson(json);

      expect(response.id, "sus");
      expect(response.description, "amogus");
      expect(response.createdAt, "at");
      expect(response.createdBy, "by");
      expect(response.modifiedAt, "modified");
      expect(response.metadata, "metadata");
      expect(response.done, true);
    });
  });
}

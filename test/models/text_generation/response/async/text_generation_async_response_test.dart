import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';

void main() {
  group("TextGenerationAsyncResponse", () {
    test("fromJson without result", () {
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
      expect(response.error?.code, 1);
      expect(response.error?.message, 'message');
      expect(response.error?.details, containsAll(["detail"]));
    });

    test("fromJson with result", () {
      final resultJson = {
        "@type": "someType",
        "alternatives": [
          {
            "message": {
              "role": "assistant",
              "text": "Hello",
            },
            "status": "ALTERNATIVE_STATUS_FINAL",
          }
        ],
        "usage": {
          "inputTextTokens": "16",
          "completionTokens": "311",
          "totalTokens": "327",
        },
        "modelVersion": "08.12.2023",
      };
      final json = {
        "id": "sus",
        "description": "amogus",
        "createdAt": "at",
        "createdBy": "by",
        "modifiedAt": "modified",
        "metadata": "metadata",
        "response": resultJson,
      };

      final response = TextGenerationAsyncResponse.fromJson(json);
      final result = response.result!;
      expect(response.id, "sus");
      expect(response.description, "amogus");
      expect(response.createdAt, "at");
      expect(response.createdBy, "by");
      expect(response.modifiedAt, "modified");
      expect(response.metadata, "metadata");
      expect(response.done, true);
      expect(result.alternatives.first.message.role, Role.assistant);
      expect(result.alternatives.first.message.text, 'Hello');
      expect(result.alternatives.first.status, GeneratingStatus.finalDone);
      expect(result.modelVersion, "08.12.2023");
      expect(result.usage.inputTextTokens, 16);
      expect(result.usage.completionTokens, 311);
      expect(result.usage.totalTokens, 327);
    });
  });
}

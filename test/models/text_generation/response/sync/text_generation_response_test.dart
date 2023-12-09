import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';

void main() {
  group("TextGenerationResponse model", () {
    test("fromJson valid", () {
      const resMessage = ResultMessage(
        message: Message(
          role: Role.assistant,
          text: "Hello world!",
        ),
        status: ResultMessageStatus.finalDone,
      );
      const usage = ModelUsage(
        inputTextTokens: 12,
        completionTokens: 4,
        totalTokens: 16,
      );
      final json = {
        "result": {
          "alternatives": [
            {
              "message": {
                "role": "assistant",
                "text": "Hello world!",
              },
              "status": "ALTERNATIVE_STATUS_FINAL"
            },
          ],
          "usage": {
            "inputTextTokens": "12",
            "completionTokens": "4",
            "totalTokens": "16",
          },
          "modelVersion": "08.12.2023",
        },
      };

      final converted = TextGenerationResponse.fromJson(json);
      expect(converted.alternatives.length, 1);
      expect(converted.alternatives.first.toString(), resMessage.toString());
      expect(converted.usage.toString(), usage.toString());
      expect(converted.modelVersion, "08.12.2023");
    });
  });
}

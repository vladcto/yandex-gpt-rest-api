import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';

void main() {
  group("TextCompletion model", () {
    test("toString valid", () {
      const response = TextCompletion(
        alternatives: [],
        usage: ModelUsage(
          inputTextTokens: 12,
          completionTokens: 6,
          totalTokens: 18,
        ),
        modelVersion: "420",
      );

      expect(response.toString(), isA<String>());
    });

    test("fromJson valid", () {
      const resMessage = ResultMessage(
        message: Message.assistant("Hello world!"),
        status: ResultMessageStatus.finalDone,
      );
      const usage = ModelUsage(
        inputTextTokens: 12,
        completionTokens: 4,
        totalTokens: 16,
      );
      final json = {
        "alternatives": [
          {
            "message": {
              "role": "assistant",
              "text": "Hello world!",
            },
            "status": "ALTERNATIVE_STATUS_FINAL",
          },
        ],
        "usage": {
          "inputTextTokens": "12",
          "completionTokens": "4",
          "totalTokens": "16",
        },
        "modelVersion": "08.12.2023",
      };

      final converted = TextCompletion.fromJson(json);
      expect(converted.alternatives.length, 1);
      expect(converted.alternatives.first.toString(), resMessage.toString());
      expect(converted.usage.toString(), usage.toString());
      expect(converted.modelVersion, "08.12.2023");
    });
  });
}

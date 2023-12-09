import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';

void main() {
  group("ResultMessage model", () {
    test("fromJson", () {
      const message = Message(
        role: Role.assistant,
        text: "Здравствуйте, мир!",
      );
      final json = {
        "message": {
          "role": "assistant",
          "text": "Здравствуйте, мир!",
        },
        "status": "ALTERNATIVE_STATUS_FINAL",
      };

      final converted = ResultMessage.fromJson(json);
      expect(converted.status, ResultMessageStatus.finalDone);
      expect(converted.message.toJson(), equals(message.toJson()));
    });
  });
}

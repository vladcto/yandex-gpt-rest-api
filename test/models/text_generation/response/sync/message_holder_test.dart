import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';

void main() {
  group("MessageHolder model", () {
    test("fromJson", () {
      const message = Message.assistant("Здравствуйте, мир!");
      final json = {
        "message": {
          "role": "assistant",
          "text": "Здравствуйте, мир!",
        },
        "status": "ALTERNATIVE_STATUS_FINAL",
      };

      final converted = MessageHolder.fromJson(json);
      expect(converted.status, MessageHolderStatus.finalDone);
      expect(converted.message.toJson(), equals(message.toJson()));
    });

    test("MessageHolderStatus unknown", () {
      final unknown = MessageHolderStatus.fromStatus('');

      expect(unknown, MessageHolderStatus.unspecified);
    });
  });
}

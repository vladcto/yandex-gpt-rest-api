import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';

void main() {
  group("Message model", () {
    test("fromJson", () {
      final json = {
        "role": "assistant",
        "text": "Hello world!",
      };
      final converted = Message.fromJson(json);
      expect(converted.role, Role.assistant);
      expect(converted.text, "Hello world!");
    });

    test("toJson", () {
      const message = Message(
        role: Role.user,
        text: "Write tests for Dart code",
      );
      final json = message.toJson();
      expect(json['role'], 'user');
      expect(json['text'], "Write tests for Dart code");
    });
  });
}

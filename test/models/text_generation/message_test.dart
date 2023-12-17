import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/roles.dart';

void main() {
  group("Message model", () {
    group("Creation", () {
      test("User creation", () {
        const message = Message.user("text");

        expect(message.text, "text");
        expect(message.role, Role.user);
      });

      test("System creation", () {
        const message = Message.system("text");

        expect(message.text, "text");
        expect(message.role, Role.system);
      });

      test("Assistant creation", () {
        const message = Message.assistant("text");

        expect(message.text, "text");
        expect(message.role, Role.assistant);
      });
    });

    group("Role test", () {
      test("User role", () {
        expect(Role.fromName(userRole), Role.user);
      });
      test("System role", () {
        expect(Role.fromName(systemRole), Role.system);
      });
      test("Assistant role", () {
        expect(Role.fromName(assistantRole), Role.assistant);
      });
      test("Unknown role", () {
        expect(Role.fromName(assistantRole), Role.assistant);
      });
    });

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

    test("hashCode", () {
      const message1 = Message(
        role: Role.user,
        text: "Write tests for Dart code",
      );
      const message2 = Message(
        role: Role.user,
        text: "Write tests for Dart code",
      );
      const otherMessage = Message(
        role: Role.assistant,
        text: "Write tests for Dart code",
      );
      expect(message1.hashCode, message2.hashCode);
      expect(message1.hashCode == otherMessage.hashCode, false);
    });
  });
}

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
      expect(converted.status, GeneratingStatus.finalDone);
      expect(converted.message.toJson(), equals(message.toJson()));
    });

    test("GeneratingStatus unknown", () {
      final unknown = GeneratingStatus.fromStatus('');

      expect(unknown, GeneratingStatus.unspecified);
    });

    test("GeneratingStatus isFinal", (){
      const done1 = GeneratingStatus.finalDone;
      const done2 = GeneratingStatus.truncatedFinal;

      const uncompleted1 = GeneratingStatus.unspecified;
      const uncompleted2 = GeneratingStatus.partial;

      expect(done1.isFinal, true);
      expect(done2.isFinal, true);
      expect(uncompleted1.isFinal, false);
      expect(uncompleted2.isFinal, false);
    });
  });
}

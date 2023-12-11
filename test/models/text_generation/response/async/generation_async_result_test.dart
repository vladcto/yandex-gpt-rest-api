import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';

void main() {
  group('ErrorAsyncResult', () {
    test('fromJson', () {
      const json = {
        "code": 1,
        "message": "message",
        "details": ["detail"],
      };

      final result = ErrorAsyncResult.fromJson(json);

      expect(result.code, 1);
      expect(result.message, "message");
      expect(result.details, ["detail"]);
    });
  });

  group('ResponseAsyncResult', () {
    test('creation', () {
      const result = ResponseAsyncResult(body: "body");

      expect(result.body, "body");
    });
  });
}

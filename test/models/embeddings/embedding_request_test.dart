import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/gpt_models/v_model.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';

void main() {
  group("EmbeddingRequest model", () {
    test("toJson", () {
      const request = EmbeddingRequest(
        model: VModel.raw('uri'),
        text: "text",
      );
      final json = request.toJson();
      expect(json['modelUri'], 'uri');
      expect(json['text'], 'text');
    });
  });
}

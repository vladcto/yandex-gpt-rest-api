import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/api_url.dart';

void main() {
  group("ApiUrl", () {
    test("Operation Url", () {
      final url = ApiUrl.operation('some_id');

      expect(url, stringContainsInOrder(["operations/some_id"]));
    });
  });
}

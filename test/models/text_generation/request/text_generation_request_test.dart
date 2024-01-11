import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/models.dart';

//ignore_for_file: avoid_redundant_argument_values
void main() {
  group("Text generation request", () {
    group("CompletionOptions model", () {
      const stream = true;
      const temperature = 0.5;
      const maxTokens = 512;
      const options = CompletionOptions(
        stream: stream,
        temperature: temperature,
        maxTokens: maxTokens,
      );

      test("toString", () {
        expect(options.toString(), isA<String>());
      });

      test("toJson valid", () {
        final json = options.toJson();
        expect(json, isA<Map<String, dynamic>>());
        expect(json['stream'], stream);
        expect(json['temperature'], temperature);
        expect(json['maxTokens'], maxTokens);
      });

      test('fromJson valid', () {
        final json = {
          "stream": stream,
          "temperature": temperature,
          "maxTokens": maxTokens,
        };
        final converted = CompletionOptions.fromJson(json);
        expect(converted.stream, stream);
        expect(converted.temperature, temperature);
        expect(converted.maxTokens, maxTokens);
      });
    });

    group("TextGenerationRequest model", () {
      const model = GModel.raw('some_uri');
      const options = CompletionOptions();
      const messages = [
        Message.system("Word"),
        Message.user("Hello"),
      ];
      const request = TextGenerationRequest(
        model: model,
        completionOptions: options,
        messages: messages,
      );

      test("toString", () {
        expect(request.toString(), isA<String>());
      });

      test('toJson', () {
        final json = request.toJson();

        expect(json, isA<Map<String, dynamic>>());
        expect(json['modelUri'], 'some_uri');
        expect(json['completionOptions'], equals(options.toJson()));
        expect(json['messages'], equals(messages));
      });

      test('fromJson', () {
        final json = {
          "modelUri": "gpt://b1gaa3g91m6j51fe49us/yandexgpt-lite",
          "completionOptions": options.toJson(),
          "messages": messages.map((e) => e.toJson()).toList(),
        };

        final converted = TextGenerationRequest.fromJson(json);
        expect(
          converted.model.uri,
          "gpt://b1gaa3g91m6j51fe49us/yandexgpt-lite",
        );
        expect(converted.completionOptions.toJson(), equals(options.toJson()));
        expect(converted.messages, equals(messages));
      });
    });
  });
}

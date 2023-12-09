import 'package:yandex_gpt_rest_sdk/src/models/models.dart';

class TextGenerationRequest {
  final String modelUri;
  final CompletionOptions completionOptions;
  final List<Message> messages;

  const TextGenerationRequest({
    required this.modelUri,
    this.completionOptions = const CompletionOptions(),
    required this.messages,
  });

  @override
  String toString() {
    return 'TextGenerationRequest{modelUri: $modelUri, '
        'completionOptions: $completionOptions, messages: $messages}';
  }

  factory TextGenerationRequest.fromJson(Map<String, dynamic> json) {
    return TextGenerationRequest(
      modelUri: json["modelUri"] as String,
      completionOptions: CompletionOptions.fromJson(
        json["completionOptions"] as Map<String, dynamic>,
      ),
      messages: List.of(json["messages"] as List<dynamic>)
          .map((i) => Message.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "modelUri": modelUri,
      "completionOptions": completionOptions.toJson(),
      "messages": messages,
    };
  }
}

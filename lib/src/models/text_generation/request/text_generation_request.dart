import 'package:yandex_gpt_rest_api/src/models/models.dart';

class TextGenerationRequest {
  final GModel model;
  final CompletionOptions completionOptions;
  final List<Message> messages;

  const TextGenerationRequest({
    required this.model,
    this.completionOptions = const CompletionOptions(),
    required this.messages,
  });

  @override
  String toString() {
    return 'TextGenerationRequest{modelUri: $model, '
        'completionOptions: $completionOptions, messages: $messages}';
  }

  factory TextGenerationRequest.fromJson(Map<String, dynamic> json) {
    return TextGenerationRequest(
      model: GModel.raw(json["modelUri"] as String),
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
      "modelUri": model.uri,
      "completionOptions": completionOptions.toJson(),
      "messages": messages,
    };
  }
}

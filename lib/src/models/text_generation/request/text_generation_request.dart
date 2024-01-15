import 'package:yandex_gpt_rest_api/src/models/models.dart';

/// Request for generating text completion.
class TextGenerationRequest {
  /// Model to be used for completion generation.
  final GModel model;

  /// Defines the options for completion generation.
  final CompletionOptions completionOptions;

  /// A list of messages representing the context for model.
  final List<Message> messages;

  /// Create request for [model] with [messages] input.
  /// For customize response use [completionOptions].
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

  /// @nodoc
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

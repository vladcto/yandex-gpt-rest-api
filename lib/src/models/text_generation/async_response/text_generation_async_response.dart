import 'package:yandex_gpt_rest_sdk/src/models/text_generation/async_response/generation_async_result.dart';

class TextGenerationAsyncResponse {
  final String id;
  final String description;

  // TODO: May i use DateTime?
  final String createdAt;
  final String createdBy;
  final String modifiedAt;
  final String metadata;
  final GenerationAsyncResult? result;

  bool get done => result != null;

  TextGenerationAsyncResponse({
    required this.id,
    required this.description,
    required this.createdAt,
    required this.createdBy,
    required this.modifiedAt,
    required this.metadata,
    required this.result,
  });

  factory TextGenerationAsyncResponse.fromJson(Map<String, dynamic> json) {
    return TextGenerationAsyncResponse(
      id: json["id"] as String,
      description: json["description"] as String,
      createdAt: json["createdAt"] as String,
      createdBy: json["createdBy"] as String,
      modifiedAt: json["modifiedAt"] as String,
      metadata: json["metadata"] as String,
      result: json["error"] != null
          ? ErrorAsyncResult.fromJson(json["error"] as Map<String, dynamic>)
          : json["response"] != null
              ? ResponseAsyncResult(body: json["response"] as String)
              : null,
    );
  }
}

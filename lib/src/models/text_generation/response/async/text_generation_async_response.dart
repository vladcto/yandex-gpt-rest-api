// TODO: Need API for operations
import 'package:yandex_gpt_rest_api/src/models/models.dart';

class TextGenerationAsyncResponse {
  final String id;
  final String description;

  // TODO: May i use DateTime?
  final String createdAt;
  final String createdBy;
  final String modifiedAt;
  final String? metadata;
  final ErrorAsyncResult? error;
  final TextGenerationResponse? response;

  bool get done => response != null || error != null;

  TextGenerationAsyncResponse({
    required this.id,
    required this.description,
    required this.createdAt,
    required this.createdBy,
    required this.modifiedAt,
    required this.metadata,
    required this.error,
    required this.response,
  });

  factory TextGenerationAsyncResponse.fromJson(Map<String, dynamic> json) {
    return TextGenerationAsyncResponse(
      id: json["id"] as String,
      description: json["description"] as String,
      createdAt: json["createdAt"] as String,
      createdBy: json["createdBy"] as String,
      modifiedAt: json["modifiedAt"] as String,
      metadata: json["metadata"] as String?,
      error: json["error"] != null
          ? ErrorAsyncResult.fromJson(json["error"] as Map<String, dynamic>)
          : null,
      response: json["response"] != null
          ? TextGenerationResponse.fromJson(
              json["response"] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

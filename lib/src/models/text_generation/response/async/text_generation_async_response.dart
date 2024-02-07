import 'package:yandex_gpt_rest_api/src/models/models.dart';

/// Request for generating text completions in asynchronous mode.
///
/// See also:
/// - [YandexGptApi.getOperationTextGenerate] - check status of operation with [id].
class TextGenerationAsyncResponse {
  /// ID of the operation in Yandex Operations API.
  final String id;

  /// Description of the operation. 0-256 characters long.
  final String description;

  /// Creation timestamp. String in RFC3339 text format.
  final String createdAt;

  /// ID of the user or service account who initiated the operation.
  final String createdBy;
  final String modifiedAt;
  final String? metadata;
  final ShortApiError? error;
  final TextCompletion? result;

  /// Is the operation FINISHED and have [result] or [error].
  bool get done => result != null || error != null;

  TextGenerationAsyncResponse({
    required this.id,
    required this.description,
    required this.createdAt,
    required this.createdBy,
    required this.modifiedAt,
    required this.metadata,
    required this.error,
    required this.result,
  });

  /// @nodoc
  factory TextGenerationAsyncResponse.fromJson(Map<String, dynamic> json) {
    return TextGenerationAsyncResponse(
      id: json["id"] as String,
      description: json["description"] as String,
      createdAt: json["createdAt"] as String,
      createdBy: json["createdBy"] as String,
      modifiedAt: json["modifiedAt"] as String,
      metadata: json["metadata"] as String?,
      error: json["error"] != null
          ? ShortApiError.fromJson(json["error"] as Map<String, dynamic>)
          : null,
      result: json["response"] != null
          ? TextCompletion.fromJson(
              json["response"] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

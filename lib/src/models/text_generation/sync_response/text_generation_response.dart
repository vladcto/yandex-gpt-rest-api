import 'package:yandex_gpt_rest_sdk/src/models/text_generation/sync_response/model_usage.dart';
import 'package:yandex_gpt_rest_sdk/src/models/text_generation/sync_response/result_message.dart';

class TextGenerationResponse {
  final List<ResultMessage> alternatives;
  final ModelUsage usage;
  final String modelVersion;

  TextGenerationResponse({
    required this.alternatives,
    required this.usage,
    required this.modelVersion,
  });

  factory TextGenerationResponse.fromJson(Map<String, dynamic> json) {
    return TextGenerationResponse(
      alternatives: List.of(json["alternatives"] as List<dynamic>)
          .map((i) => ResultMessage.fromJson(i as Map<String, dynamic>))
          .toList(),
      usage: ModelUsage.fromJson(json["usage"] as Map<String, Object>),
      modelVersion: json["modelVersion"] as String,
    );
  }
}

import 'package:yandex_gpt_rest_sdk/src/models/models.dart';

class TextGenerationResponse {
  final List<ResultMessage> alternatives;
  final ModelUsage usage;
  final String modelVersion;

  TextGenerationResponse({
    required this.alternatives,
    required this.usage,
    required this.modelVersion,
  });

  @override
  String toString() {
    return 'TextGenerationResponse{alternatives: $alternatives, usage: $usage, modelVersion: $modelVersion}';
  }

  factory TextGenerationResponse.fromJson(Map<String, dynamic> json) {
    json = json["result"] as Map<String, dynamic>;

    return TextGenerationResponse(
      alternatives: List.of(json["alternatives"] as List<dynamic>)
          .map((i) => ResultMessage.fromJson(i as Map<String, dynamic>))
          .toList(),
      usage: ModelUsage.fromJson(json["usage"] as Map<String, dynamic>),
      modelVersion: json["modelVersion"] as String,
    );
  }
}

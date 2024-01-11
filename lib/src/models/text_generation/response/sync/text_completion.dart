import 'package:yandex_gpt_rest_api/src/models/models.dart';

class TextCompletion {
  final List<MessageHolder> alternatives;
  final ModelUsage usage;
  final String modelVersion;

  const TextCompletion({
    required this.alternatives,
    required this.usage,
    required this.modelVersion,
  });

  @override
  String toString() {
    return 'TextCompletion{alternatives: $alternatives, usage: $usage, modelVersion: $modelVersion}';
  }

  factory TextCompletion.fromJson(Map<String, dynamic> json) {
    return TextCompletion(
      alternatives: List.of(json["alternatives"] as List<dynamic>)
          .map((i) => MessageHolder.fromJson(i as Map<String, dynamic>))
          .toList(),
      usage: ModelUsage.fromJson(json["usage"] as Map<String, dynamic>),
      modelVersion: json["modelVersion"] as String,
    );
  }
}

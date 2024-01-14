import 'package:yandex_gpt_rest_api/src/models/gpt_models/v_model.dart';

class EmbeddingRequest {
  final VModel model;

  /// The input text for which the embedding is requested.
  final String text;

  const EmbeddingRequest({required this.model, required this.text});

  Map<String, dynamic> toJson() {
    return {
      "modelUri": model.uri,
      "text": text,
    };
  }
}

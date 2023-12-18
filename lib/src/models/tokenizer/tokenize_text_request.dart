import 'package:yandex_gpt_rest_api/src/models/gpt_models/g_model.dart';

class TokenizeTextRequest {
  final GModel model;
  final String text;

  const TokenizeTextRequest({required this.model, required this.text});

  Map<String, dynamic> toJson() {
    return {
      "modelUri": model.uri,
      "text": text,
    };
  }
}

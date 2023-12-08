import 'package:yandex_gpt_rest_sdk/src/models/tokenizer/token.dart';

class TokenizeResponse {
  final List<Token> tokens;
  final String modelVersion;

  TokenizeResponse({required this.tokens, required this.modelVersion});

  factory TokenizeResponse.fromJson(Map<String, dynamic> json) {
    return TokenizeResponse(
      tokens: List.of(json["tokens"] as List<dynamic>)
          .map((i) => Token.fromJson(i as Map<String, dynamic>))
          .toList(),
      modelVersion: json["modelVersion"] as String,
    );
  }
//
}

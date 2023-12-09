class TokenizeTextRequest {
  final String modelUri;
  final String text;

  const TokenizeTextRequest({required this.modelUri, required this.text});

  factory TokenizeTextRequest.fromJson(Map<String, dynamic> json) {
    return TokenizeTextRequest(
      modelUri: json["modelUri"] as String,
      text: json["text"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "modelUri": modelUri,
      "text": text,
    };
  }
}

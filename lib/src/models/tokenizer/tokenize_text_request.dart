class TokenizeTextRequest {
  final String modelUri;
  final String text;

  const TokenizeTextRequest({required this.modelUri, required this.text});

  Map<String, dynamic> toJson() {
    return {
      "modelUri": modelUri,
      "text": text,
    };
  }
}

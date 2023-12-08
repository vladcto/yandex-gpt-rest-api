class EmbeddingRequest {
  final String modelUri;
  final String text;

  EmbeddingRequest({required this.modelUri, required this.text});

  Map<String, dynamic> toJson() {
    return {
      "modelUri": modelUri,
      "text": text,
    };
  }
}

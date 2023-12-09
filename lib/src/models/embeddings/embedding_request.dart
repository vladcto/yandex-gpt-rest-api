class EmbeddingRequest {
  final String modelUri;
  final String text;

  const EmbeddingRequest({required this.modelUri, required this.text});

  Map<String, dynamic> toJson() {
    return {
      "modelUri": modelUri,
      "text": text,
    };
  }
}

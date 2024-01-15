/// Response containing generated text embedding
class EmbeddingResponse {
  /// A repeated list of double values representing the embedding.
  final List<double> embedding;

  /// The number of tokens in the input text.
  final int numTokens;
  final String modelVersion;

  const EmbeddingResponse({
    required this.embedding,
    required this.numTokens,
    required this.modelVersion,
  });

  @override
  String toString() {
    return 'EmbeddingResponse{embedding: $embedding, numTokens: $numTokens, modelVersion: $modelVersion}';
  }

  /// @nodoc
  factory EmbeddingResponse.fromJson(Map<String, dynamic> json) {
    return EmbeddingResponse(
      embedding: List.of(json["embedding"] as List<dynamic>)
          .map((i) => i as double)
          .toList(),
      numTokens: int.parse(json["numTokens"] as String),
      modelVersion: json["modelVersion"] as String,
    );
  }
}

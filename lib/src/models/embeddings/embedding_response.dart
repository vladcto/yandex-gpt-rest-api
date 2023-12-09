class EmbeddingResponse {
  final List<double> embedding;
  final int numTokens;
  final String modelVersion;

  EmbeddingResponse({
    required this.embedding,
    required this.numTokens,
    required this.modelVersion,
  });

  @override
  String toString() {
    return 'EmbeddingResponse{embedding: $embedding, numTokens: $numTokens, modelVersion: $modelVersion}';
  }

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

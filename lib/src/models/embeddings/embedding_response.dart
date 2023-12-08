class EmbeddingResponse {
  final List<double> embedding;
  final int numTokens;
  final String modelVersion;

  EmbeddingResponse({
    required this.embedding,
    required this.numTokens,
    required this.modelVersion,
  });

  factory EmbeddingResponse.fromJson(Map<String, dynamic> json) {
    return EmbeddingResponse(
      embedding: List.of(json["embedding"] as List<String>)
          .map((i) => double.parse(i))
          .toList(),
      numTokens: int.parse(json["numTokens"] as String),
      modelVersion: json["modelVersion"] as String,
    );
  }
}

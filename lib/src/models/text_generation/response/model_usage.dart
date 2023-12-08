class ModelUsage {
  final int tokens;
  final int completionTokens;
  final int totalTokens;

  ModelUsage({
    required this.tokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory ModelUsage.fromJson(Map<String, dynamic> json) {
    return ModelUsage(
      tokens: int.parse(json["tokens"] as String),
      completionTokens: int.parse(json["completionTokens"] as String),
      totalTokens: int.parse(json["totalTokens"] as String),
    );
  }
}

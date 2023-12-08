class ModelUsage {
  final int inputTextTokens;
  final int completionTokens;
  final int totalTokens;

  ModelUsage({
    required this.inputTextTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  @override
  String toString() {
    return 'ModelUsage{inputTextTokens: $inputTextTokens, completionTokens: $completionTokens, totalTokens: $totalTokens}';
  }

  factory ModelUsage.fromJson(Map<String, dynamic> json) {
    return ModelUsage(
      inputTextTokens: int.parse(json["inputTextTokens"] as String),
      completionTokens: int.parse(json["completionTokens"] as String),
      totalTokens: int.parse(json["totalTokens"] as String),
    );
  }
}

/// A set of statistics describing the number of content tokens used by the completion model.
class ModelUsage {
  /// The number of tokens in the text parts of the model input.
  final int inputTextTokens;

  /// The total number of tokens in the generated completions.
  final int completionTokens;

  /// The total number of tokens, including all input tokens and all generated tokens.
  final int totalTokens;

  const ModelUsage({
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

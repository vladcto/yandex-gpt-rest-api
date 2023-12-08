class CompletionOptions {
  final bool stream;
  final double temperature;

  // TODO: assert
  final int maxTokens;

  CompletionOptions({
    required this.stream,
    required this.temperature,
    required this.maxTokens,
  }) : assert(
          0 <= temperature && temperature <= 1,
          "Temperature must be in 0 <= t <= 1",
        );

  @override
  String toString() {
    return 'CompletionOptions{stream: $stream, temperature: $temperature, maxTokens: $maxTokens}';
  }

  factory CompletionOptions.fromJson(Map<String, dynamic> json) {
    return CompletionOptions(
      stream: (json["stream"] as String).toLowerCase() == 'true',
      temperature: double.parse(json["temperature"] as String),
      maxTokens: int.parse(json["maxTokens"] as String),
    );
  }
}

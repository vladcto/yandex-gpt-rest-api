class CompletionOptions {
  final bool stream;
  final double temperature;

  // TODO: assert
  final int maxTokens;

  const CompletionOptions({
    this.stream = false,
    this.temperature = 0.1,
    this.maxTokens = 1024,
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

  Map<String, dynamic> toJson() {
    return {
      "stream": stream,
      "temperature": temperature,
      "maxTokens": maxTokens,
    };
  }
}

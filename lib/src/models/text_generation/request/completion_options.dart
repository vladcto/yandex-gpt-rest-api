class CompletionOptions {
  /// Enables streaming of partially generated text.
  final bool stream;

  /// Affects creativity and randomness of responses.
  final double temperature;

  /// The limit on the number of tokens used for single completion generation.
  final int maxTokens;

  /// Create configuration for completion with:
  /// - [temperature] - lower values produce more straightforward responses,
  /// while higher values lead to increased creativity and randomness
  /// - [maxTokens] - limit of used tokens.
  /// The maximum allowed parameter value may depend on the model used.
  /// - [stream] - enables streaming of partially generated text.
  const CompletionOptions({
    this.stream = false,
    this.temperature = 0.6,
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
      stream: json["stream"] as bool,
      temperature: json["temperature"] as double,
      maxTokens: json["maxTokens"] as int,
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

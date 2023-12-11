sealed class GenerationAsyncResult {
  const GenerationAsyncResult();
}

final class ErrorAsyncResult extends GenerationAsyncResult {
  final int code;
  final String message;
  final List<String> details;

  ErrorAsyncResult({
    required this.code,
    required this.message,
    required this.details,
  });

  factory ErrorAsyncResult.fromJson(Map<String, dynamic> json) {
    return ErrorAsyncResult(
      code: (json["code"] as int?) ?? int.parse(json["code"] as String),
      message: json["message"] as String,
      details: List.of(json["details"] as List<dynamic>)
          .map((i) => i as String)
          .toList(),
    );
  }
}

final class ResponseAsyncResult extends GenerationAsyncResult {
  final String body;

  const ResponseAsyncResult({required this.body});
}

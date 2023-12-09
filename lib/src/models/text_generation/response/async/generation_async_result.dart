sealed class GenerationAsyncResult {}

final class ErrorAsyncResult extends GenerationAsyncResult {
  final int code;
  final String message;
  final List<String> details;

  ErrorAsyncResult({
    required this.code,
    required this.message,
    required this.details,
  });

  // TODO: Exactly as String? not int?
  factory ErrorAsyncResult.fromJson(Map<String, dynamic> json) {
    return ErrorAsyncResult(
      code: int.parse(json["code"] as String),
      message: json["message"] as String,
      details: List.of(json["details"] as List<dynamic>)
          .map((i) => json["details"] as String)
          .toList(),
    );
  }
}

final class ResponseAsyncResult extends GenerationAsyncResult {
  final String body;

  ResponseAsyncResult({required this.body});
}

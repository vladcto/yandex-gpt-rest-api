/// All errors are of the YandexGPT API side.
///
/// See also:
/// - [DetailedApiError]
/// - [ShortApiError]
sealed class ApiError {
  /// Error code. An enum value of [Google.Rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto).
  final int grpcCode;

  /// An error message.
  final String message;

  /// A list of messages that carry the error details.
  final List<String> details;

  ApiError({
    required this.grpcCode,
    required this.message,
    required this.details,
  });

  static ApiError? tryParseJson(Map<String, dynamic> json) {
    try {
      return DetailedApiError.fromJson(json);
    } catch (_) {}
    try {
      return ShortApiError.fromJson(json);
    } catch (_) {}
    return null;
  }
}

/// YandexGPT API call error.
/// Almost always requests return this error.
///
/// See also:
/// - [ShortApiError]
/// - [ApiError]
final class DetailedApiError extends ApiError {
  final int httpCode;
  final String httpStatus;

  DetailedApiError({
    required this.httpCode,
    required this.httpStatus,
    required super.message,
    required super.grpcCode,
    required super.details,
  });

  factory DetailedApiError.fromJson(Map<String, dynamic> json) {
    json = json['error'] as Map<String, dynamic>;

    return DetailedApiError(
      grpcCode: json["grpcCode"] as int,
      httpCode: json["httpCode"] as int,
      message: json["message"] as String,
      httpStatus: json["httpStatus"] as String,
      details: List.of(json["details"] as List<dynamic>).cast<String>(),
    );
  }
}

/// Error for the entire Yandex API. For example, the quota has expired.
/// Rarely used.
///
/// See also:
/// - [DetailedApiError]
/// - [ApiError]
final class ShortApiError extends ApiError {
  ShortApiError({
    required super.grpcCode,
    required super.message,
    required super.details,
  });

  factory ShortApiError.fromJson(Map<String, dynamic> json) {
    return ShortApiError(
      grpcCode: json["code"] as int,
      message: json["message"] as String,
      details: List.of(json["details"] as List<dynamic>).cast<String>(),
    );
  }
}

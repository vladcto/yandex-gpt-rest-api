sealed class ApiError {
  ApiError();
}

final class CanceledError extends ApiError {
  CanceledError();
}

sealed class ContractApiError extends ApiError {
  static ContractApiError? tryParseJson(Map<String, dynamic> json) {
    try {
      return DetailedApiError.fromJson(json);
    } catch (_) {}
    try {
      return ShortApiError.fromJson(json);
    } catch (_) {}
    return null;
  }
}

final class DetailedApiError extends ContractApiError {
  final int grpcCode;
  final int httpCode;
  final String message;
  final String httpStatus;
  final List<String> details;

  DetailedApiError({
    required this.grpcCode,
    required this.httpCode,
    required this.message,
    required this.httpStatus,
    required this.details,
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

final class ShortApiError extends ContractApiError {
  final String error;
  final int code;
  final String message;
  final List<String> details;

  ShortApiError({
    required this.error,
    required this.code,
    required this.message,
    required this.details,
  });

  factory ShortApiError.fromJson(Map<String, dynamic> json) {
    return ShortApiError(
      error: json["error"] as String,
      code: json["code"] as int,
      message: json["message"] as String,
      details: List.of(json["details"] as List<dynamic>).cast<String>(),
    );
  }
}

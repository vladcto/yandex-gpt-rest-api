sealed class ApiError {
  ApiError();
}

final class CanceledApiError extends ApiError {
  CanceledApiError();
}

final class NetworkApiError extends ApiError {
  final int? statusCode;
  final String? body;

  NetworkApiError({
    this.statusCode,
    this.body,
  });
}

// TODO: Separate to diff classes
final class ContractApiError extends ApiError {
  final int? grpcCode;
  final int? httpCode;
  final int? code;
  final String message;
  final String? httpStatus;
  final List<String> details;

  ContractApiError({
    required this.grpcCode,
    required this.httpCode,
    required this.code,
    required this.message,
    required this.httpStatus,
    required this.details,
  });

  factory ContractApiError.fromJson(Map<String, dynamic> json) {
    return ContractApiError(
      grpcCode: json["grpcCode"] as int?,
      httpCode: json["httpCode"] as int?,
      code: json["code"] as int?,
      message: json["message"] as String,
      httpStatus: json["httpStatus"] as String?,
      details: List.of(json["details"] as List<dynamic>)
          .map((i) => i as String)
          .toList(),
    );
  }
//
}

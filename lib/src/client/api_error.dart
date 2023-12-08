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

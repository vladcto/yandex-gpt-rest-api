import 'package:test/test.dart';
import 'package:yandex_gpt_rest_api/src/models/errors/api_error.dart';

void main() {
  group('DetailedApiError model', () {
    test('creation', () {
      final detailedError = DetailedApiError(
        grpcCode: 1,
        httpCode: 500,
        message: 'Test detailed error',
        httpStatus: 'Internal Server Error',
        details: ['detail1', 'detail2'],
      );

      expect(detailedError.grpcCode, 1);
      expect(detailedError.httpCode, 500);
      expect(detailedError.message, 'Test detailed error');
      expect(detailedError.httpStatus, 'Internal Server Error');
      expect(detailedError.details, ['detail1', 'detail2']);
    });

    test('fromJson', () {
      final json = {
        'error': {
          'grpcCode': 1,
          'httpCode': 500,
          'message': 'Test detailed error',
          'httpStatus': 'Internal Server Error',
          'details': ['detail1', 'detail2'],
        },
      };

      final detailedError = DetailedApiError.fromJson(json);

      expect(detailedError.grpcCode, 1);
      expect(detailedError.httpCode, 500);
      expect(detailedError.message, 'Test detailed error');
      expect(detailedError.httpStatus, 'Internal Server Error');
      expect(detailedError.details, ['detail1', 'detail2']);
    });
  });

  group('ShortApiError model', () {
    test('creation', () {
      final shortError = ShortApiError(
        grpcCode: 400,
        message: 'Bad Request',
        details: ['detail1', 'detail2'],
      );

      expect(shortError.grpcCode, 400);
      expect(shortError.message, 'Bad Request');
      expect(shortError.details, ['detail1', 'detail2']);
    });

    test('fromJson', () {
      final json = {
        'code': 400,
        'message': 'Bad Request',
        'details': ['detail1', 'detail2'],
      };

      final shortError = ShortApiError.fromJson(json);

      expect(shortError.grpcCode, 400);
      expect(shortError.message, 'Bad Request');
      expect(shortError.details, ['detail1', 'detail2']);
    });
  });

  group('ContractApiError model', () {
    test('tryParseJson with DetailedApiError', () {
      final json = {
        'error': {
          'grpcCode': 1,
          'httpCode': 500,
          'message': 'Test detailed error',
          'httpStatus': 'Internal Server Error',
          'details': ['detail1', 'detail2'],
        },
      };

      final result = ApiError.tryParseJson(json) as DetailedApiError?;

      expect(result, isA<DetailedApiError>());
      expect(result?.grpcCode, 1);
      expect(result?.httpCode, 500);
      expect(result?.message, 'Test detailed error');
      expect(result?.httpStatus, 'Internal Server Error');
      expect(result?.details, ['detail1', 'detail2']);
    });

    test('tryParseJson with ShortApiError', () {
      final json = {
        'code': 400,
        'message': 'Bad Request',
        'details': ['detail1', 'detail2'],
      };

      final result = ApiError.tryParseJson(json) as ShortApiError?;

      expect(result, isA<ShortApiError>());
      expect(result?.grpcCode, 400);
      expect(result?.message, 'Bad Request');
      expect(result?.details, ['detail1', 'detail2']);
    });

    test('tryParseJson with unknown format', () {
      final json = {'amogus': 'sus'};
      final result = ApiError.tryParseJson(json);
      expect(result, isNull);
    });
  });
}

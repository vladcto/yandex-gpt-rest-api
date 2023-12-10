import 'package:async/async.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/logic/helper/api_cancel_token.dart';

void main() {
  group("ApiCancelToken test", () {
    test("Creation", () {
      final token = ApiCancelToken();
      expect(token.haveCancellables, false);
      expect(token.isClosed, false);
    });

    test("Add cancellable", () {
      final token = ApiCancelToken();
      token.attachCancellable(CancelableOperation.fromValue(1));
      expect(token.haveCancellables, true);
      expect(token.isClosed, false);
    });

    test("Remove same cancellable", () {
      final token = ApiCancelToken();
      final cancelable = CancelableOperation.fromValue(1);
      token.attachCancellable(cancelable);
      token.detachCancellable(cancelable);
      expect(token.haveCancellables, false);
      expect(token.isClosed, false);
    });

    test("Remove other cancellable", () {
      final token = ApiCancelToken();
      final cancelable = CancelableOperation.fromValue(1);
      token.attachCancellable(cancelable);
      token.detachCancellable(CancelableOperation.fromValue(1));
      expect(token.haveCancellables, true);
      expect(token.isClosed, false);
    });

    test("Can cancel", () {
      final token = ApiCancelToken();
      token.attachCancellable(CancelableOperation.fromValue(1));
      token.close();
      expect(token.isClosed, true);
      expect(token.haveCancellables, true);
    });

    test("Can close empty", () {
      final token = ApiCancelToken();
      token.close();
      expect(token.haveCancellables, false);
      expect(token.isClosed, true);
    });

    test("Closing future throws error", () async {
      final token = ApiCancelToken();
      final operation = CancelableOperation.fromFuture(
        Future.delayed(const Duration(seconds: 2), () => 1),
      );
      token.attachCancellable(operation);
      Future(() => token.close());
      await expectLater(
        operation.then((p0) => 0, onCancel: () => throw Exception()).value,
        throwsException,
      );
    });
  });
}

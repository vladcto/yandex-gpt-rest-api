import 'package:async/async.dart';

final class ApiCancelToken {
  final List<CancelableOperation> _cancellables = [];

  bool _closed = false;

  bool get isClosed => _closed;

  bool get haveCancellables => _cancellables.isNotEmpty;

  void close() {
    if (_closed) return;
    _closed = true;
    for (final operation in _cancellables) {
      operation.cancel();
    }
  }

  void attachCancellable(CancelableOperation operation) {
    if (_closed) return;
    _cancellables.add(operation);
  }

  void detachCancellable(CancelableOperation operation) {
    if (_closed) return;
    _cancellables.remove(operation);
  }
}

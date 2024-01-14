import 'package:yandex_gpt_rest_api/src/models/models.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/alternative_status.dart';

/// The generation status of the alternative.
enum GeneratingStatus {
  /// Unspecified generation status.
  unspecified,
  /// Partially generated alternative.
  partial,
  /// Incomplete final alternative resulting from reaching the maximum allowed number of tokens.
  truncatedFinal,
  /// Final alternative generated without running into any limits.
  finalDone;

  factory GeneratingStatus.fromStatus(String status) {
    return switch (status) {
      AlternativeStatus.finalDone => GeneratingStatus.finalDone,
      AlternativeStatus.truncatedFinal => GeneratingStatus.truncatedFinal,
      AlternativeStatus.partial => GeneratingStatus.partial,
      _ => GeneratingStatus.unspecified
    };
  }

  /// Is generated alternative finished.
  bool get isFinal => this == truncatedFinal || this == finalDone;
}

/// Wrapper for [Message] with generate status [GeneratingStatus].
class MessageHolder {
  final Message message;
  final GeneratingStatus status;

  const MessageHolder({required this.message, required this.status});

  @override
  String toString() {
    return 'MessageHolder{message: $message, status: $status}';
  }

  factory MessageHolder.fromJson(Map<String, dynamic> json) {
    return MessageHolder(
      message: Message.fromJson(json["message"] as Map<String, dynamic>),
      status: GeneratingStatus.fromStatus(json["status"] as String),
    );
  }
}

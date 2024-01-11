import 'package:yandex_gpt_rest_api/src/models/models.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/alternative_status.dart';

enum MessageHolderStatus {
  unspecified,
  partial,
  truncatedFinal,
  finalDone;

  factory MessageHolderStatus.fromStatus(String status) {
    return switch (status) {
      AlternativeStatus.finalDone => MessageHolderStatus.finalDone,
      AlternativeStatus.truncatedFinal => MessageHolderStatus.truncatedFinal,
      AlternativeStatus.partial => MessageHolderStatus.partial,
      _ => MessageHolderStatus.unspecified
    };
  }
}

class MessageHolder {
  final Message message;
  final MessageHolderStatus status;

  const MessageHolder({required this.message, required this.status});

  @override
  String toString() {
    return 'MessageHolder{message: $message, status: $status}';
  }

  factory MessageHolder.fromJson(Map<String, dynamic> json) {
    return MessageHolder(
      message: Message.fromJson(json["message"] as Map<String, dynamic>),
      status: MessageHolderStatus.fromStatus(json["status"] as String),
    );
  }
}

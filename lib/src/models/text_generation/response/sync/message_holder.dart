import 'package:yandex_gpt_rest_api/src/models/models.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/alternative_status.dart';

enum ResultMessageStatus {
  unspecified,
  partial,
  truncatedFinal,
  finalDone;

  factory ResultMessageStatus.fromStatus(String status) {
    return switch (status) {
      AlternativeStatus.finalDone => ResultMessageStatus.finalDone,
      AlternativeStatus.truncatedFinal => ResultMessageStatus.truncatedFinal,
      AlternativeStatus.partial => ResultMessageStatus.partial,
      _ => ResultMessageStatus.unspecified
    };
  }
}

class MessageHolder {
  final Message message;
  final ResultMessageStatus status;

  const MessageHolder({required this.message, required this.status});

  @override
  String toString() {
    return 'ResultMessage{message: $message, status: $status}';
  }

  factory MessageHolder.fromJson(Map<String, dynamic> json) {
    return MessageHolder(
      message: Message.fromJson(json["message"] as Map<String, dynamic>),
      status: ResultMessageStatus.fromStatus(json["status"] as String),
    );
  }
}

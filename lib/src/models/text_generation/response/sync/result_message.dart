import 'package:yandex_gpt_rest_api/src/models/models.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/alternative_status.dart';

enum ResultMessageStatus {
  unspecified,
  partial,
  truncatedFinal,
  finalDone;

  factory ResultMessageStatus.fromStatus(String status) {
    return switch (status) {
      AlternativeStatus.unspecified => ResultMessageStatus.unspecified,
      AlternativeStatus.partial => ResultMessageStatus.partial,
      AlternativeStatus.truncatedFinal => ResultMessageStatus.truncatedFinal,
      AlternativeStatus.finalDone => ResultMessageStatus.finalDone,
      // TODO: Normal error message
      _ => ResultMessageStatus.unspecified
    };
  }
}

class ResultMessage {
  final Message message;
  final ResultMessageStatus status;

  const ResultMessage({required this.message, required this.status});

  @override
  String toString() {
    return 'ResultMessage{message: $message, status: $status}';
  }

  factory ResultMessage.fromJson(Map<String, dynamic> json) {
    return ResultMessage(
      message: Message.fromJson(json["message"] as Map<String, dynamic>),
      status: ResultMessageStatus.fromStatus(json["status"] as String),
    );
  }
}

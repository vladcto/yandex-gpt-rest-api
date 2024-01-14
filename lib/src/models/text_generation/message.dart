import 'package:yandex_gpt_rest_api/src/utils/constants/roles.dart';

enum Role {
  user,
  system,
  assistant;

  factory Role.fromName(String name) {
    return switch (name) {
      userRole => Role.user,
      systemRole => Role.system,
      _ => Role.assistant,
    };
  }

  @override
  String toString() => name;
}

class Message {
  final Role role;
  final String text;

  const Message._({required this.text, required this.role});

  /// Message by the user to describe requests to the model.
  const Message.user(this.text) : role = Role.user;

  /// Message used to define the behaviour of the completion model.
  const Message.system(this.text) : role = Role.system;

  /// Message used by the model to generate responses.
  const Message.assistant(this.text) : role = Role.assistant;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          runtimeType == other.runtimeType &&
          role == other.role &&
          text == other.text);

  @override
  int get hashCode => role.hashCode ^ text.hashCode;

  @override
  String toString() {
    return 'Message{role: $role, text: $text}';
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message._(
      role: Role.fromName(json["role"] as String),
      text: json["text"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "role": role.toString(),
      "text": text,
    };
  }
}

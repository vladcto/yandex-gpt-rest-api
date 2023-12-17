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

  const Message({
    required this.role,
    required this.text,
  });

  const Message.user(String text) : this(text: text, role: Role.user);

  const Message.system(String text) : this(text: text, role: Role.system);

  const Message.assistant(String text) : this(text: text, role: Role.assistant);

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
    return Message(
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

class Message {
  // TODO: Maybe enum?
  final String role;
  final String text;

  const Message({
    required this.role,
    required this.text,
  });

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
      role: json["role"] as String,
      text: json["text"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "role": role,
      "text": text,
    };
  }
}

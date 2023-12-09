class Token {
  final String id;
  final String text;
  final bool special;

  Token({required this.id, required this.text, required this.special});

  @override
  String toString() {
    return 'Token{id: $id, text: $text, special: $special}';
  }

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      id: json["id"] as String,
      text: json["text"] as String,
      special: json["special"] as bool,
    );
  }
}

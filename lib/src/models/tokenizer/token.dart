class Token {
  // TODO: Web and working with int64
  final String id;
  final String text;
  final bool special;

  Token({required this.id, required this.text, required this.special});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      id: json["id"] as String,
      text: json["text"] as String,
      special: (json["special"] as String).toLowerCase() == 'true',
    );
  }
//
}

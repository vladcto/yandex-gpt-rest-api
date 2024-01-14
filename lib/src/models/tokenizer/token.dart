class Token {
  /// An internal token identifier.
  final String id;
  /// The textual representation of the token.
  final String text;
  /// Indicates whether the token is special or not. Special tokens may define the model's behavior and are not visible to users.
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

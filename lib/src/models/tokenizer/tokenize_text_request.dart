class TokenizeTextRequest {
  final String modelUrl;
  final String text;

  TokenizeTextRequest({required this.modelUrl, required this.text});

  factory TokenizeTextRequest.fromJson(Map<String, dynamic> json) {
    return TokenizeTextRequest(
      modelUrl: json["modelUrl"] as String,
      text: json["text"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "modelUrl": modelUrl,
      "text": text,
    };
  }
}

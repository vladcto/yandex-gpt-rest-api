abstract class AiModel {
  final String uri;

  const AiModel.raw({required this.uri});

  @override
  String toString() => uri;
}

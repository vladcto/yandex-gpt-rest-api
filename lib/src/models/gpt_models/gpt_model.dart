abstract class GptModel {
  final String uri;

  const GptModel.raw({required this.uri});

  const GptModel.version({required String uri, String? version})
      : uri = '$uri/${version ?? 'latest'}';

  @override
  String toString() => uri;
}

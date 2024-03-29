abstract final class ApiUrl {
  static const _apiHost = "https://llm.api.cloud.yandex.net";
  static const _foundationHost = "$_apiHost/foundationModels/v1";

  static const textGeneration = "$_foundationHost/completion";
  static const textGenerationAsync = "$_foundationHost/completionAsync";
  static const tokenizeText = "$_foundationHost/tokenize";
  static const tokenizeCompletion = "$_foundationHost/tokenizeCompletion";
  static const textEmbedding = "$_foundationHost/textEmbedding";

  static String operation(String id) => "$_apiHost/operations/$id";
}

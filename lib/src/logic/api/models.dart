import 'package:yandex_gpt_rest_sdk/src/utils/constants/models_uri.dart';

abstract final class GModels {
  static String yandexGpt(String folderId) {
    return gptPrefix + folderId + yandexGptPostfix;
  }

  static String yandexGptLight(String folderId) {
    return gptPrefix + folderId + yandexGptLitePostfix;
  }

  static String summary(String folderId) {
    return gptPrefix + folderId + summaryPostfix;
  }

  static String fineTuned(String modelId) {
    return dsPrefix + modelId;
  }
}

abstract final class VModels {
  static String searchQueries(String folderId) {
    return embPrefix + folderId + textSearchQueryPostfix;
  }

  static String documentation(String folderId){
    return embPrefix + folderId + textSearchDocPostfix;
  }
}

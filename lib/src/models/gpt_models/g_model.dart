import 'package:yandex_gpt_rest_api/src/models/gpt_models/gpt_model.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/models_uri.dart';

/// Generation models.
///
/// Check [Yandex docs](https://cloud.yandex.ru/en/docs/yandexgpt/concepts/models#yandexgpt-generation) for more info.
class GModel extends GptModel {
  const GModel.raw(String uri) : super.raw(uri: uri);

  const GModel.yandexGpt(String folderId, {super.version})
      : super.version(uri: gptPrefix + folderId + yandexGptPostfix);

  const GModel.yandexGptLight(String folderId, {super.version})
      : super.version(uri: gptPrefix + folderId + yandexGptLitePostfix);

  const GModel.summary(String folderId, {super.version})
      : super.version(uri: gptPrefix + folderId + summaryPostfix);

  const GModel.fineTuned(String modelId) : this.raw(dsPrefix + modelId);
}

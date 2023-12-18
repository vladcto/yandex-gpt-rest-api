import 'package:yandex_gpt_rest_api/src/logic/api/ai_models/ai_model.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/models_uri.dart';

class GModel extends AiModel {
  const GModel.raw(String uri) : super.raw(uri: uri);

  const GModel.yandexGpt(String folderId)
      : this.raw(gptPrefix + folderId + yandexGptPostfix);

  const GModel.yandexGptLight(String folderId)
      : this.raw(gptPrefix + folderId + yandexGptLitePostfix);

  const GModel.summary(String folderId)
      : this.raw(gptPrefix + folderId + summaryPostfix);

  const GModel.fineTuned(String modelId) : this.raw(dsPrefix + modelId);
}

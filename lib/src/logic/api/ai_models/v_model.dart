import 'package:yandex_gpt_rest_api/src/logic/api/ai_models/ai_model.dart';

import 'package:yandex_gpt_rest_api/src/utils/constants/models_uri.dart';

class VModel extends AiModel {
  const VModel.raw(String uri) : super.raw(uri: uri);

  const VModel.searchQueries(String folderId)
      : this.raw(embPrefix + folderId + textSearchQueryPostfix);

  const VModel.documentation(String folderId)
      : this.raw(embPrefix + folderId + textSearchDocPostfix);
}

import 'package:yandex_gpt_rest_api/src/models/gpt_models/gpt_model.dart';
import 'package:yandex_gpt_rest_api/src/utils/constants/models_uri.dart';

/// Models for vector representation of text.
///
/// Check [Yandex docs](https://cloud.yandex.ru/en/docs/yandexgpt/concepts/models#yandexgpt-embeddings) for more info.
class VModel extends GptModel {
  const VModel.raw(String uri) : super.raw(uri: uri);

  const VModel.searchQueries(String folderId, {super.version})
      : super.version(uri: embPrefix + folderId + textSearchQueryPostfix);

  const VModel.documentation(String folderId, {super.version})
      : super.version(uri: embPrefix + folderId + textSearchDocPostfix);
}

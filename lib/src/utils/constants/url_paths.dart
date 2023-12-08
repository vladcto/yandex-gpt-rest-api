const _host = "llm.api.cloud.yandex.net";
const _base = "foundationModels/v1";

final textGenerationUri = Uri.https(_host, "$_base/completion");
final textGenerationAsyncUri = Uri.https(_host, "$_base/completionAsync");
final tokenizeTextUri = Uri.https(_host, "$_base/completionAsync");
final tokenizeCompletionUri = Uri.https(_host, "$_base/tokenizeCompletion");
final textEmbeddingUri = Uri.https(_host, "$_base/textEmbedding");

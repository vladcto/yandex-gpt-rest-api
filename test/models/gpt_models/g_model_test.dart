// ignore_for_file: prefer_const_constructors

import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:yandex_gpt_rest_api/src/models/gpt_models/g_model.dart';

void main() {
  group("GModel", () {
    const folderId = 'folderId';
    const modelId = 'modelId';
    const latest = 'latest';
    final versionRegexp = RegExp('.+/$folderId/.+/$modelId');
    final latestVersionRegexp = RegExp('.+/$folderId/.+/$latest');

    test("Raw", () {
      final model = GModel.raw(folderId);
      expect(model.uri, folderId);
    });

    test("YandexGpt with version", () {
      final model = GModel.yandexGpt(folderId, version: modelId);
      expect(versionRegexp.hasMatch(model.uri), true);
    });

    test("YandexGpt without version", () {
      final model = GModel.yandexGpt(folderId);
      expect(latestVersionRegexp.hasMatch(model.uri), true);
    });

    test("YandexGptLight with version", () {
      final model = GModel.yandexGptLight(folderId, version: modelId);
      expect(versionRegexp.hasMatch(model.uri), true);
    });

    test("YandexGptLight without version", () {
      final model = GModel.yandexGpt(folderId);
      expect(latestVersionRegexp.hasMatch(model.uri), true);
    });

    test("Summary with version", () {
      final model = GModel.summary(folderId, version: modelId);
      expect(versionRegexp.hasMatch(model.uri), true);
    });

    test("Summary without version", () {
      final model = GModel.summary(folderId);
      expect(latestVersionRegexp.hasMatch(model.uri), true);
    });

    test("FineTuned with version", () {
      final model = GModel.fineTuned(modelId);
      expect(model.uri.contains(RegExp('.*/$modelId')), true);
    });
  });
}

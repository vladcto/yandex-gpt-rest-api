// ignore_for_file: prefer_const_constructors

import 'package:test/test.dart';
import 'package:yandex_gpt_rest_api/src/models/gpt_models/v_model.dart';

void main() {
  group("GModel", () {
    const folderId = 'folderId';
    const modelId = 'modelId';
    const latest = 'latest';
    final versionRegexp = RegExp('.+/$folderId/.+/$modelId');
    final latestVersionRegexp = RegExp('.+/$folderId/.+/$latest');

    test("Raw", () {
      final model = VModel.raw(folderId);
      expect(model.uri, folderId);
    });

    test("Documentation with version", () {
      final model = VModel.documentation(folderId, version: modelId);
      expect(versionRegexp.hasMatch(model.uri), true);
    });

    test("Documentation without version", () {
      final model = VModel.documentation(folderId);
      expect(latestVersionRegexp.hasMatch(model.uri), true);
    });

    test("SearchQueries with version", () {
      final model = VModel.searchQueries(folderId, version: modelId);
      expect(versionRegexp.hasMatch(model.uri), true);
    });

    test("SearchQueries without version", () {
      final model = VModel.searchQueries(folderId);
      expect(latestVersionRegexp.hasMatch(model.uri), true);
    });
  });
}

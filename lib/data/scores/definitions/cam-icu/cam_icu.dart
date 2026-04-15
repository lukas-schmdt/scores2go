import 'package:scores_2_go/data/scores/definitions/cam-icu/cam_icu_function.dart';
import 'package:scores_2_go/data/scores/definitions/cam-icu/cam_icu_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/cam-icu/cam_icu_visibility.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = CamIcuI10n();

Score buildCamIcuScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 14,
    name: 'cam-icu',
    display: t('display'),
    description: t('description'),
    author: 'Ely et al.',
    year: 2001,
    popularity: 85,
    categories: ['Delirium', 'ICU'],
    doc: (_) => 'lib/data/scores/definitions/cam-icu/cam_icu_doc.md',
    scoreFunction: camIcuFunction,
    visibilityFunction: camIcuVisibility,
    groups: [
      Group(
        name: 'cam-icu-assessment',
        display: t('group.display'),
        description: t('group.description'),
        isVisible: true,
        items: [
          VariableBool(
            name: 'cam-icu-feature1',
            display: t('feature1.display'),
            description: t('feature1.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'cam-icu-feature2',
            display: t('feature2.display'),
            description: t('feature2.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'cam-icu-feature3',
            display: t('feature3.display'),
            description: t('feature3.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'cam-icu-feature4',
            display: t('feature4.display'),
            description: t('feature4.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
        ],
      ),
    ],
  );
}

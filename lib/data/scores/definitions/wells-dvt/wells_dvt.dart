import 'package:scores_2_go/data/scores/definitions/wells-dvt/wells_dvt_function.dart';
import 'package:scores_2_go/data/scores/definitions/wells-dvt/wells_dvt_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/wells-dvt/wells_dvt_visibility.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = WellsDvtI10n();

Score buildWellsDvtScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 22,
    name: 'wells-dvt',
    display: t('display'),
    description: t('description'),
    scoreFunction: (s) => wellsDvtFunction(s, lang),
    visibilityFunction: wellsDvtVisibility,
    docUrl: (locale) => locale == 'de'
        ? 'https://scores2go.com/scores/de/wells-dvt.html'
        : 'https://scores2go.com/scores/wells-dvt.html',
    author: 'Wells et al.',
    year: 2003,
    categories: ['Emergency', 'Vascular'],
    groups: [
      Group(
        name: 'wells-dvt-criteria',
        display: t('group.criteria.display'),
        description: t('group.criteria.description'),
        isVisible: true,
        items: [
          VariableBool(
            name: 'wells-dvt-cancer',
            display: t('cancer.display'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'wells-dvt-paralysis',
            display: t('paralysis.display'),
            description: t('paralysis.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'wells-dvt-bedridden-surgery',
            display: t('bedridden-surgery.display'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'wells-dvt-tenderness',
            display: t('tenderness.display'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'wells-dvt-entire-leg-swollen',
            display: t('entire-leg-swollen.display'),
            description: t('entire-leg-swollen.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'wells-dvt-calf-swelling',
            display: t('calf-swelling.display'),
            description: t('calf-swelling.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'wells-dvt-pitting-edema',
            display: t('pitting-edema.display'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'wells-dvt-collateral-veins',
            display: t('collateral-veins.display'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'wells-dvt-previous-dvt',
            display: t('previous-dvt.display'),
            description: t('previous-dvt.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'wells-dvt-alternative-diagnosis',
            display: t('alternative-diagnosis.display'),
            description: t('alternative-diagnosis.description'),
            value: null,
            trueValue: -2,
            falseValue: 0,
          ),
        ],
      ),
    ],
  );
}

import 'package:scores_2_go/data/scores/definitions/wells-pe/wells_pe_function.dart';
import 'package:scores_2_go/data/scores/definitions/wells-pe/wells_pe_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/wells-pe/wells_pe_visibility.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = WellsPeI10n();

Score buildWellsPeScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 21,
    name: 'wells-pe',
    display: t('display'),
    description: t('description'),
    scoreFunction: (s) => wellsPeFunction(s, lang),
    visibilityFunction: wellsPeVisibility,
    docUrl: (locale) => locale == 'de'
        ? 'https://scores2go.com/scores/de/wells-pe.html'
        : 'https://scores2go.com/scores/wells-pe.html',
    author: 'Wells et al.',
    year: 2000,
    popularity: 85,
    categories: ['Emergency', 'Pulmonology'],
    groups: [
      Group(
        name: 'wells-pe-criteria',
        display: t('group.criteria.display'),
        description: t('group.criteria.description'),
        isVisible: true,
        items: [
          VariableBool(
            name: 'wells-pe-dvt-signs',
            display: t('dvt-signs.display'),
            description: t('dvt-signs.description'),
            value: null,
            trueValue: 3,
            falseValue: 0,
          ),
          VariableBool(
            name: 'wells-pe-pe-likely',
            display: t('pe-likely.display'),
            value: null,
            trueValue: 3,
            falseValue: 0,
          ),
          VariableBool(
            name: 'wells-pe-heart-rate',
            display: t('heart-rate.display'),
            value: null,
            trueValue: 1.5,
            falseValue: 0,
          ),
          VariableBool(
            name: 'wells-pe-immobilization-surgery',
            display: t('immobilization-surgery.display'),
            value: null,
            trueValue: 1.5,
            falseValue: 0,
          ),
          VariableBool(
            name: 'wells-pe-previous-vte',
            display: t('previous-vte.display'),
            value: null,
            trueValue: 1.5,
            falseValue: 0,
          ),
          VariableBool(
            name: 'wells-pe-hemoptysis',
            display: t('hemoptysis.display'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'wells-pe-malignancy',
            display: t('malignancy.display'),
            description: t('malignancy.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
        ],
      ),
    ],
  );
}

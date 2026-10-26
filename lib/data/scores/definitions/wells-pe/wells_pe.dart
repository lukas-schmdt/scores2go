import 'package:scores_2_go/data/scores/definitions/wells-pe/wells_pe_function.dart';
import 'package:scores_2_go/data/scores/definitions/wells-pe/wells_pe_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/wells-pe/wells_pe_visibility.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = WellsPeI10n();

Score buildWellsPeScore(String lang) {
  String t(String key) => _i10n.t(lang, key);

  VariableBool criterion(String key, num points) => VariableBool(
    name: 'wells-pe-$key',
    display: t('$key.display'),
    description: t('$key.description'),
    value: null,
    trueValue: points,
    falseValue: 0,
  );

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
          criterion('dvt-signs', 3),
          criterion('pe-likely', 3),
          criterion('heart-rate', 1.5),
          criterion('immobilization-surgery', 1.5),
          criterion('previous-vte', 1.5),
          criterion('hemoptysis', 1),
          criterion('malignancy', 1),
        ],
      ),
    ],
  );
}

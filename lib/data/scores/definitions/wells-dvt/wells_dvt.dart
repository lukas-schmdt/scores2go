import 'package:scores_2_go/data/scores/definitions/wells-dvt/wells_dvt_function.dart';
import 'package:scores_2_go/data/scores/definitions/wells-dvt/wells_dvt_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/wells-dvt/wells_dvt_visibility.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = WellsDvtI10n();

Score buildWellsDvtScore(String lang) {
  String t(String key) => _i10n.t(lang, key);

  VariableBool criterion(String key, num points) => VariableBool(
    name: 'wells-dvt-$key',
    display: t('$key.display'),
    description: t('$key.description'),
    value: null,
    trueValue: points,
    falseValue: 0,
  );

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
    popularity: 85,
    categories: ['Emergency', 'Vascular'],
    groups: [
      Group(
        name: 'wells-dvt-criteria',
        display: t('group.criteria.display'),
        description: t('group.criteria.description'),
        isVisible: true,
        items: [
          criterion('cancer', 1),
          criterion('paralysis', 1),
          criterion('bedridden-surgery', 1),
          criterion('tenderness', 1),
          criterion('entire-leg-swollen', 1),
          criterion('calf-swelling', 1),
          criterion('pitting-edema', 1),
          criterion('collateral-veins', 1),
          criterion('previous-dvt', 1),
          criterion('alternative-diagnosis', -2),
        ],
      ),
    ],
  );
}

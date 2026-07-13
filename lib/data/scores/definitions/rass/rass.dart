import 'package:scores_2_go/data/scores/definitions/rass/rass_function.dart';
import 'package:scores_2_go/data/scores/definitions/rass/rass_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/rass/rass_visibility.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = RassI10n();

Score buildRassScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 7,
    name: 'rass',
    doc: (_) => 'lib/data/scores/definitions/rass/rass_doc.md',
    docUrl: (locale) => locale == 'de'
        ? 'https://scores2go.com/scores/de/rass.html'
        : 'https://scores2go.com/scores/rass.html',
    scoreFunction: rassFunction,
    visibilityFunction: rassVisibility,
    author: 'Sessler et al.',
    year: 2002,
    popularity: 90,
    categories: ['Sedation', 'ICU'],
    display: t('display'),
    description: t('description'),
    groups: [
      Group(
        name: 'rass-assessment',
        display: t('group.display'),
        description: t('group.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'rass-level',
            display: t('level.display'),
            description: t('level.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('level.plus4'), value: 4),
              VariableOption(display: t('level.plus3'), value: 3),
              VariableOption(display: t('level.plus2'), value: 2),
              VariableOption(display: t('level.plus1'), value: 1),
              VariableOption(display: t('level.zero'), value: 0),
              VariableOption(display: t('level.minus1'), value: -1),
              VariableOption(display: t('level.minus2'), value: -2),
              VariableOption(display: t('level.minus3'), value: -3),
              VariableOption(display: t('level.minus4'), value: -4),
              VariableOption(display: t('level.minus5'), value: -5),
            ],
          ),
        ],
      ),
    ],
  );
}

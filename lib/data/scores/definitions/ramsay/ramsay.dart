import 'package:scores_2_go/data/scores/definitions/ramsay/ramsay_function.dart';
import 'package:scores_2_go/data/scores/definitions/ramsay/ramsay_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/ramsay/ramsay_visibility.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = RamsayI10n();

Score buildRamsayScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 8,
    name: 'ramsay',
    doc: (_) => 'lib/data/scores/definitions/ramsay/ramsay_doc.md',
    scoreFunction: ramsayFunction,
    visibilityFunction: ramsayVisibility,
    author: 'Ramsay et al.',
    year: 1974,
    popularity: 72,
    categories: ['Sedation', 'ICU'],
    display: t('display'),
    description: t('description'),
    groups: [
      Group(
        name: 'ramsay-assessment',
        display: t('group.display'),
        description: t('group.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'ramsay-level',
            display: t('level.display'),
            description: t('level.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('level.1'), value: 1),
              VariableOption(display: t('level.2'), value: 2),
              VariableOption(display: t('level.3'), value: 3),
              VariableOption(display: t('level.4'), value: 4),
              VariableOption(display: t('level.5'), value: 5),
              VariableOption(display: t('level.6'), value: 6),
            ],
          ),
        ],
      ),
    ],
  );
}

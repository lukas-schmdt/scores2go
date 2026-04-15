import 'package:scores_2_go/data/scores/definitions/horovitz/horovitz_function.dart';
import 'package:scores_2_go/data/scores/definitions/horovitz/horovitz_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/horovitz/horovitz_visibility.dart';
import 'package:scores_2_go/function/value_unit_converter.dart';
import 'package:scores_2_go/model/model.dart';
import 'package:scores_2_go/model/unit_definition.dart';

final _i10n = HorovitzI10n();

/// FiO₂: canonical unit is % (21–100). No conversion needed in the function.
const _fio2Units = [
  UnitDefinition(label: '%'),
];

Score buildHorovitzScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 12,
    name: 'horovitz',
    display: t('display'),
    description: t('description'),
    author: 'Horovitz et al.',
    year: 1974,
    popularity: 85,
    categories: ['Pulmonology', 'ICU', 'ARDS'],
    doc: (_) => 'lib/data/scores/definitions/horovitz/horovitz_doc.md',
    scoreFunction: horovitzFunction,
    visibilityFunction: horovitzVisibility,
    groups: [
      Group(
        name: 'horovitz-oxygenation',
        display: t('oxygenation.group.display'),
        description: t('oxygenation.group.description'),
        isVisible: true,
        items: [
          VariableNumber(
            name: 'horovitz-pao2',
            display: t('pao2.display'),
            description: t('pao2.description'),
            value: null,
            normMin: 80,
            normMax: 100,
            units: Units.pressure, // mmHg canonical, kPa alternative
          ),
          VariableNumber(
            name: 'horovitz-fio2',
            display: t('fio2.display'),
            description: t('fio2.description'),
            value: null,
            normMin: 21,
            normMax: 100,
            units: _fio2Units,
          ),
        ],
      ),
    ],
  );
}

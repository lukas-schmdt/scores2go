import 'package:scores_2_go/data/scores/definitions/horovitz/horovitz_function.dart';
import 'package:scores_2_go/data/scores/definitions/horovitz/horovitz_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/horovitz/horovitz_visibility.dart';
import 'package:scores_2_go/function/value_unit_converter.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = HorovitzI10n();

/// FiO₂: canonical unit is % (21–100). No conversion needed in the function.
const _fio2Units = [
  UnitDefinition(label: '%'),
];

/// PEEP: single unit, cmH₂O. Units.pressure (mmHg/kPa) does not apply here.
const _peepUnits = [
  UnitDefinition(label: 'cmH₂O'),
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
    docUrl: (locale) => locale == 'de'
        ? 'https://scores2go.com/scores/de/horovitz.html'
        : 'https://scores2go.com/scores/horovitz.html',
    scoreFunction: (s) => horovitzFunction(s, lang),
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
          VariableNumber(
            name: 'horovitz-peep',
            display: t('peep.display'),
            description: t('peep.description'),
            value: null,
            normMin: 5,
            normMax: 15,
            units: _peepUnits,
          ),
        ],
      ),
    ],
  );
}

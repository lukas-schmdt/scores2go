import 'package:scores_2_go/data/scores/definitions/saps-ii/saps_ii_function.dart';
import 'package:scores_2_go/data/scores/definitions/saps-ii/saps_ii_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/saps-ii/saps_ii_visibility.dart';
import 'package:scores_2_go/function/value_unit_converter.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = SapsIiI10n();

Score buildSapsIiScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 4,
    name: 'saps-ii',
    scoreFunction: sapsIiFunction,
    visibilityFunction: sapsIiVisibility,
    display: 'SAPS II',
    description: t('description'),
    groups: [
      Group(
        name: 'saps-ii-demografie_aufnahme',
        display: t('group.demografie.display'),
        description: t('group.demografie.description'),
        items: [
          VariableSelection(
            name: 'saps-ii-alter',
            display: t('alter.display'),
            description: t('alter.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('alter.opt.lt40'), value: 0),
              VariableOption(display: t('alter.opt.40_59'), value: 7),
              VariableOption(display: t('alter.opt.60_69'), value: 12),
              VariableOption(display: t('alter.opt.70_74'), value: 15),
              VariableOption(display: t('alter.opt.75_79'), value: 16),
              VariableOption(display: t('alter.opt.ge80'), value: 18),
            ],
          ),
          VariableSelection(
            name: 'saps-ii-aufnahmeart',
            display: t('aufnahmeart.display'),
            description: t('aufnahmeart.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('aufnahmeart.opt.elective'), value: 0),
              VariableOption(display: t('aufnahmeart.opt.medical'), value: 6),
              VariableOption(
                display: t('aufnahmeart.opt.emergency'),
                value: 8,
              ),
            ],
          ),
          VariableSelection(
            name: 'saps-ii-chronische_erkrankungen',
            display: t('chronische_erkrankungen.display'),
            description: t('chronische_erkrankungen.description'),
            type: VariableType.select,
            options: [
              VariableOption(
                display: t('chronische_erkrankungen.opt.none'),
                value: 0,
              ),
              VariableOption(
                display: t('chronische_erkrankungen.opt.metastatic'),
                value: 9,
              ),
              VariableOption(
                display: t('chronische_erkrankungen.opt.hematologic'),
                value: 10,
              ),
              VariableOption(
                display: t('chronische_erkrankungen.opt.aids'),
                value: 17,
              ),
            ],
          ),
        ],
      ),
      Group(
        name: 'saps-ii-vitalparameter',
        display: t('group.vitals.display'),
        description: t('group.vitals.description'),
        items: [
          VariableSelection(
            name: 'saps-ii-herzfrequenz',
            display: t('herzfrequenz.display'),
            description: t('herzfrequenz.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: '< 40 /min', value: 11),
              VariableOption(display: '40 – 69 /min', value: 2),
              VariableOption(display: '70 – 119 /min', value: 0),
              VariableOption(display: '120 – 159 /min', value: 4),
              VariableOption(display: '≥ 160 /min', value: 7),
            ],
          ),
          VariableSelection(
            name: 'saps-ii-systolischer_blutdruck',
            display: t('systolischer_blutdruck.display'),
            description: t('systolischer_blutdruck.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: '< 70 mmHg', value: 13),
              VariableOption(display: '70 – 99 mmHg', value: 5),
              VariableOption(display: '100 – 199 mmHg', value: 0),
              VariableOption(display: '≥ 200 mmHg', value: 2),
            ],
          ),
          VariableSelection(
            name: 'saps-ii-temperatur',
            display: t('temperatur.display'),
            description: t('temperatur.description'),
            type: VariableType.select,
            units: Units.temperature,
            options: [
              VariableOption(
                display: '< 39 °C',
                displays: ['< 39 °C', '< 102,2 °F'],
                value: 0,
              ),
              VariableOption(
                display: '≥ 39 °C',
                displays: ['≥ 39 °C', '≥ 102,2 °F'],
                value: 3,
              ),
            ],
          ),
          VariableSelection(
            name: 'saps-ii-gcs',
            display: t('gcs.display'),
            description: t('gcs.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: '< 6', value: 26),
              VariableOption(display: '6 – 8', value: 13),
              VariableOption(display: '9 – 10', value: 7),
              VariableOption(display: '11 – 13', value: 5),
              VariableOption(display: '14 – 15', value: 0),
            ],
          ),
          VariableBool(
            name: 'saps-ii-beatmet_oder_cpap',
            display: t('beatmet_oder_cpap.display'),
            description: t('beatmet_oder_cpap.description'),
            value: null,
            trueValue: 0,
            falseValue: 0,
          ),
          VariableSelection(
            name: 'saps-ii-pao2_fio2',
            display: t('pao2_fio2.display'),
            description: t('pao2_fio2.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: '< 100 mmHg', value: 11),
              VariableOption(display: '100 – 199 mmHg', value: 9),
              VariableOption(display: '≥ 200 mmHg', value: 6),
            ],
          ),
          VariableSelection(
            name: 'saps-ii-urinausscheidung',
            display: t('urinausscheidung.display'),
            description: t('urinausscheidung.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: '< 500 mL/24 h', value: 11),
              VariableOption(display: '500 – 999 mL/24 h', value: 4),
              VariableOption(display: '≥ 1000 mL/24 h', value: 0),
            ],
          ),
        ],
      ),
      Group(
        name: 'saps-ii-labor',
        display: t('group.labor.display'),
        description: t('group.labor.description'),
        items: [
          VariableSelection(
            name: 'saps-ii-bun',
            display: t('bun.display'),
            description: t('bun.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: '< 28 mg/dL', value: 0),
              VariableOption(display: '28 – 83 mg/dL', value: 6),
              VariableOption(display: '≥ 84 mg/dL', value: 10),
            ],
          ),
          VariableSelection(
            name: 'saps-ii-leukozyten',
            display: t('leukozyten.display'),
            description: t('leukozyten.description'),
            type: VariableType.select,
            units: Units.leukocytes,
            options: [
              VariableOption(
                display: '< 1 ×10³/µL',
                displays: ['< 1 ×10³/µL', '< 1 ×10⁹/L'],
                value: 12,
              ),
              VariableOption(
                display: '1 – 19,9 ×10³/µL',
                displays: ['1 – 19,9 ×10³/µL', '1 – 19,9 ×10⁹/L'],
                value: 0,
              ),
              VariableOption(
                display: '≥ 20 ×10³/µL',
                displays: ['≥ 20 ×10³/µL', '≥ 20 ×10⁹/L'],
                value: 3,
              ),
            ],
          ),
          VariableSelection(
            name: 'saps-ii-kalium',
            display: t('kalium.display'),
            description: t('kalium.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: '< 3,0 mmol/L', value: 3),
              VariableOption(display: '3,0 – 4,9 mmol/L', value: 0),
              VariableOption(display: '≥ 5,0 mmol/L', value: 3),
            ],
          ),
          VariableSelection(
            name: 'saps-ii-natrium',
            display: t('natrium.display'),
            description: t('natrium.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: '< 125 mmol/L', value: 5),
              VariableOption(display: '125 – 144 mmol/L', value: 0),
              VariableOption(display: '≥ 145 mmol/L', value: 1),
            ],
          ),
          VariableSelection(
            name: 'saps-ii-bicarbonat',
            display: t('bicarbonat.display'),
            description: t('bicarbonat.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: '< 15 mmol/L', value: 6),
              VariableOption(display: '15 – 19 mmol/L', value: 3),
              VariableOption(display: '≥ 20 mmol/L', value: 0),
            ],
          ),
          VariableSelection(
            name: 'saps-ii-bilirubin',
            display: t('bilirubin.display'),
            description: t('bilirubin.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: '< 4,0 mg/dL', value: 0),
              VariableOption(display: '4,0 – 5,9 mg/dL', value: 4),
              VariableOption(display: '≥ 6,0 mg/dL', value: 9),
            ],
          ),
        ],
      ),
    ],
  );
}

import 'package:scores_2_go/data/scores/definitions/meld-3/meld_3_function.dart';
import 'package:scores_2_go/data/scores/definitions/meld-3/meld_3_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/meld-3/meld_3_visibility.dart';
import 'package:scores_2_go/function/value_unit_converter.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = Meld3I10n();

/// Albumin: canonical unit is g/dL, with g/L as the convertible alternative
/// (factor 10). `Units` has no albumin preset, so it is defined locally
/// here, following the pattern used for FiO2/PEEP in horovitz.dart.
const _albuminUnits = [
  UnitDefinition(label: 'g/dL'),
  UnitDefinition(label: 'g/L', factor: 10),
];

/// Sodium: mEq/L and mmol/L are numerically identical, so only a single
/// inline unit is offered rather than a second, factor-1 "alternative".
const _sodiumUnits = [UnitDefinition(label: 'mmol/L')];

Score buildMeld3Score(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 20,
    name: 'meld-3',
    display: t('display'),
    description: t('description'),
    author: 'Kim et al.',
    year: 2021,
    popularity: 86,
    categories: ['Hepatology', 'Transplant', 'Severity'],
    docUrl: (locale) => locale == 'de'
        ? 'https://scores2go.com/scores/de/meld-3.html'
        : 'https://scores2go.com/scores/meld-3.html',
    scoreFunction: (s) => meld3Function(s, lang),
    visibilityFunction: meld3Visibility,
    groups: [
      Group(
        name: 'meld3-patient',
        display: t('sex.group.display'),
        description: t('sex.group.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'meld3-sex',
            display: t('sex.display'),
            description: t('sex.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('sex.opt.male'), value: 0),
              VariableOption(display: t('sex.opt.female'), value: 1.33),
            ],
          ),
        ],
      ),
      Group(
        name: 'meld3-liver',
        display: t('liver.group.display'),
        description: t('liver.group.description'),
        isVisible: true,
        items: [
          VariableNumber(
            name: 'meld3-bilirubin',
            display: t('bilirubin.display'),
            description: t('bilirubin.description'),
            value: null,
            normMin: 0.2,
            normMax: 1.2,
            units: Units.bilirubin,
          ),
        ],
      ),
      Group(
        name: 'meld3-coagulation',
        display: t('coagulation.group.display'),
        description: t('coagulation.group.description'),
        isVisible: true,
        items: [
          VariableNumber(
            name: 'meld3-inr',
            display: t('inr.display'),
            description: t('inr.description'),
            value: null,
            normMin: 0.8,
            normMax: 1.2,
          ),
        ],
      ),
      Group(
        name: 'meld3-renal',
        display: t('renal.group.display'),
        description: t('renal.group.description'),
        isVisible: true,
        items: [
          VariableNumber(
            name: 'meld3-creatinine',
            display: t('creatinine.display'),
            description: t('creatinine.description'),
            value: null,
            normMin: 0.5,
            normMax: 1.2,
            units: Units.creatinine,
          ),
          VariableBool(
            name: 'meld3-dialysis',
            display: t('dialysis.display'),
            description: t('dialysis.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
        ],
      ),
      Group(
        name: 'meld3-electrolytes',
        display: t('electrolytes.group.display'),
        description: t('electrolytes.group.description'),
        isVisible: true,
        items: [
          VariableNumber(
            name: 'meld3-sodium',
            display: t('sodium.display'),
            description: t('sodium.description'),
            value: null,
            normMin: 135,
            normMax: 145,
            units: _sodiumUnits,
          ),
        ],
      ),
      Group(
        name: 'meld3-nutrition',
        display: t('nutrition.group.display'),
        description: t('nutrition.group.description'),
        isVisible: true,
        items: [
          VariableNumber(
            name: 'meld3-albumin',
            display: t('albumin.display'),
            description: t('albumin.description'),
            value: null,
            normMin: 3.5,
            normMax: 5.0,
            units: _albuminUnits,
          ),
        ],
      ),
    ],
  );
}

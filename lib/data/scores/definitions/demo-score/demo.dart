import 'package:scores_2_go/data/scores/definitions/demo-score/demo_function.dart';
import 'package:scores_2_go/data/scores/definitions/demo-score/demo_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/demo-score/demo_visibility.dart';
import 'package:scores_2_go/function/value_unit_converter.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = DemoScoreI10n();

Score buildDemoScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 0,
    name: 'demo-score',
    scoreFunction: demoScoreFunction,
    visibilityFunction: demoScoreVisibility,
    display: t('display'),
    description: t('description'),
    groups: [
      Group(
        name: 'demo-score-vitals',
        display: t('group.vitals.display'),
        description: t('group.vitals.description'),
        isVisible: true,
        items: [
          VariableBool(
            name: 'demo-score-o2_therapy',
            display: t('o2_therapy.display'),
            description: t('o2_therapy.description'),
            value: null,
            trueValue: 2,
            falseValue: 0,
          ),
          VariableNumber(
            name: 'demo-score-temperature',
            display: t('temperature.display'),
            description: t('temperature.description'),
            value: null,
            normMin: 36.1,
            normMax: 37.9,
            units: Units.temperature,
          ),
          VariableSelection(
            name: 'demo-score-alertness',
            display: t('alertness.display'),
            description: t('alertness.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('alertness.alert'), value: 0),
              VariableOption(display: t('alertness.voice'), value: 1),
              VariableOption(display: t('alertness.unresponsive'), value: 2),
            ],
          ),
        ],
      ),
      Group(
        name: 'demo-score-respiratory',
        display: t('group.respiratory.display'),
        description: t('group.respiratory.description'),
        isVisible: true,
        items: [
          VariableBool(
            name: 'demo-score-ventilated',
            display: t('ventilated.display'),
            description: t('ventilated.description'),
            value: null,
            trueValue: 0,
            falseValue: 0,
          ),
          VariableSelection(
            name: 'demo-score-fio2',
            display: t('fio2.display'),
            description: t('fio2.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: '21 % (room air)', value: 0),
              VariableOption(display: '40 %', value: 1),
              VariableOption(display: '60 %', value: 2),
              VariableOption(display: '≥ 80 %', value: 3),
            ],
          ),
        ],
      ),
      Group(
        name: 'demo-score-risk_factors',
        display: t('group.risk_factors.display'),
        description: t('group.risk_factors.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'demo-score-comorbidities',
            display: t('comorbidities.display'),
            description: t('comorbidities.description'),
            type: VariableType.multiselect,
            options: [
              VariableOption(display: t('comorbidities.diabetes'), value: 1),
              VariableOption(display: t('comorbidities.copd'), value: 1),
              VariableOption(display: t('comorbidities.ckd'), value: 1),
              VariableOption(display: t('comorbidities.immuno'), value: 2),
            ],
          ),
          VariableSelection(
            name: 'demo-score-blood_sugar',
            display: t('blood_sugar.display'),
            description: t('blood_sugar.description'),
            type: VariableType.select,
            units: Units.glucose,
            options: [
              VariableOption(
                display: '< 60 mg/dL',
                displays: ['< 60 mg/dL', '< 3.3 mmol/L'],
                value: 2,
              ),
              VariableOption(
                display: '60 – 89 mg/dL',
                displays: ['60 – 89 mg/dL', '3.3 – 4.9 mmol/L'],
                value: 1,
              ),
              VariableOption(
                display: '90 – 110 mg/dL',
                displays: ['90 – 110 mg/dL', '5.0 – 6.1 mmol/L'],
                value: 0,
              ),
              VariableOption(
                display: '> 110 mg/dL',
                displays: ['> 110 mg/dL', '> 6.1 mmol/L'],
                value: 1,
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

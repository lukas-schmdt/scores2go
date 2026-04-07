import 'package:scores_2_go/data/scores/definitions/demo-score/demo_function.dart';
import 'package:scores_2_go/data/scores/definitions/demo-score/demo_visibility.dart';
import 'package:scores_2_go/function/value_unit_converter.dart';
import 'package:scores_2_go/model/model.dart';

Score buildDemoScore() => Score(
  id: 1,
  name: 'demo-score',
  scoreFunction: demoScoreFunction,
  visibilityFunction: demoScoreVisibility,
  display: 'Demo Score',
  description:
      'Demonstration score covering all variable types: boolean, '
      'number, single-select, multi-select, and conditional activation.',
  groups: [
    Group(
      name: 'demo-score-vitals',
      display: 'Vitals',
      description: 'Core vital parameters.',
      items: [
        VariableBool(
          name: 'demo-score-o2_therapy',
          display: 'Supplemental O₂',
          description: 'Is the patient receiving supplemental oxygen?',
          value: null,
          trueValue: 2,
          falseValue: 0,
        ),
        VariableNumber(
          name: 'demo-score-temperature',
          display: 'Temperature',
          description:
              'Body temperature. Tap the unit label to switch °C / °F.',
          value: null,
          normMin: 36.1,
          normMax: 37.9,
          units: Units.temperature,
        ),
        VariableSelection(
          name: 'demo-score-alertness',
          display: 'Alertness',
          description: 'Level of consciousness.',
          type: VariableType.select,
          options: [
            VariableOption(display: 'Alert', value: 0),
            VariableOption(display: 'Responds to voice', value: 1),
            VariableOption(display: 'Unresponsive', value: 2),
          ],
        ),
      ],
    ),
    Group(
      name: 'demo-score-respiratory',
      display: 'Respiratory',
      description: 'Ventilation parameters.',
      items: [
        VariableBool(
          name: 'demo-score-ventilated',
          display: 'Mechanical Ventilation',
          description: 'Is the patient on mechanical ventilation or CPAP?',
          value: null,
          trueValue: 0,
          falseValue: 0,
        ),
        VariableSelection(
          name: 'demo-score-fio2',
          display: 'FiO₂',
          description:
              'Fraction of inspired oxygen. Only shown when ventilated.',
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
      display: 'Risk Factors',
      description: 'Select all applicable comorbidities.',
      items: [
        VariableSelection(
          name: 'demo-score-comorbidities',
          display: 'Comorbidities',
          description: 'All applicable conditions.',
          type: VariableType.multiselect,
          options: [
            VariableOption(display: 'Diabetes', value: 1),
            VariableOption(display: 'COPD', value: 1),
            VariableOption(display: 'Chronic kidney disease', value: 1),
            VariableOption(display: 'Immunosuppression', value: 2),
          ],
        ),
        VariableSelection(
          name: 'demo-score-blood_sugar',
          display: 'Blood Sugar',
          description: 'Tap the unit label to switch mg/dL ↔ mmol/L.',
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

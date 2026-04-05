import 'package:scores_2_go_2/model/score.dart';
import 'package:scores_2_go_2/model/score_group.dart';
import 'package:scores_2_go_2/model/variable.dart';
import 'package:scores_2_go_2/model/variable_bool.dart';
import 'package:scores_2_go_2/model/variable_number.dart';
import 'package:scores_2_go_2/model/variable_selection.dart';
import 'package:scores_2_go_2/function/value_unit_converter.dart';

var scoresDb = [
  Score(
    id: 1,
    name: 'demo-score',
    display: 'Demo Score',
    description:
        'Demonstration score covering all variable types: boolean, '
        'number, single-select, multi-select, and conditional activation.',
    groups: [
      Group(
        id: 1,
        name: 'vitals',
        display: 'Vitals',
        description: 'Core vital parameters.',
        items: [
          VariableBool(
            id: 1,
            name: 'o2_therapy',
            display: 'Supplemental O₂',
            description: 'Is the patient receiving supplemental oxygen?',
            value: null,
            trueValue: 2,
            falseValue: 0,
          ),
          // Number – optional, unit-switchable (°C ↔ °F), used in secondary
          VariableNumber(
            id: 2,
            name: 'temperature',
            display: 'Temperature',
            description:
                'Body temperature. Tap the unit label to switch °C / °F.',
            value: null,
            normMin: 36.1,
            normMax: 37.9,
            units: Units.temperature,
          ),
          VariableSelection(
            id: 3,
            name: 'alertness',
            display: 'Alertness',
            description: 'Level of consciousness.',
            type: VariableType.select,
            options: [
              VariableOption(id: 1, display: 'Alert', value: 0),
              VariableOption(id: 2, display: 'Responds to voice', value: 1),
              VariableOption(id: 3, display: 'Unresponsive', value: 2),
            ],
          ),
        ],
      ),
      Group(
        id: 2,
        name: 'respiratory',
        display: 'Respiratory',
        description: 'Ventilation parameters.',
        items: [
          VariableBool(
            id: 4,
            name: 'ventilated',
            display: 'Mechanical Ventilation',
            description: 'Is the patient on mechanical ventilation or CPAP?',
            value: null,
            trueValue: 0,
            falseValue: 0,
          ),
          VariableSelection(
            id: 5,
            name: 'fio2',
            display: 'FiO₂',
            description:
                'Fraction of inspired oxygen. Only shown when ventilated.',
            type: VariableType.select,
            options: [
              VariableOption(id: 1, display: '21 % (room air)', value: 0),
              VariableOption(id: 2, display: '40 %', value: 1),
              VariableOption(id: 3, display: '60 %', value: 2),
              VariableOption(id: 4, display: '≥ 80 %', value: 3),
            ],
          ),
        ],
      ),
      Group(
        id: 3,
        name: 'risk_factors',
        display: 'Risk Factors',
        description: 'Select all applicable comorbidities.',
        items: [
          VariableSelection(
            id: 6,
            name: 'comorbidities',
            display: 'Comorbidities',
            description: 'All applicable conditions.',
            type: VariableType.multiselect,
            options: [
              VariableOption(id: 1, display: 'Diabetes', value: 1),
              VariableOption(id: 2, display: 'COPD', value: 1),
              VariableOption(
                id: 3,
                display: 'Chronic kidney disease',
                value: 1,
              ),
              VariableOption(id: 4, display: 'Immunosuppression', value: 2),
            ],
          ),
          VariableSelection(
            id: 7,
            name: 'blood_sugar',
            display: 'Blood Sugar',
            description: 'Tap the unit label to switch mg/dL ↔ mmol/L.',
            type: VariableType.select,
            units: Units.glucose,
            options: [
              VariableOption(
                id: 1,
                display: '< 60 mg/dL',
                displays: ['< 60 mg/dL', '< 3.3 mmol/L'],
                value: 2,
              ),
              VariableOption(
                id: 2,
                display: '60 – 89 mg/dL',
                displays: ['60 – 89 mg/dL', '3.3 – 4.9 mmol/L'],
                value: 1,
              ),
              VariableOption(
                id: 3,
                display: '90 – 110 mg/dL',
                displays: ['90 – 110 mg/dL', '5.0 – 6.1 mmol/L'],
                value: 0,
              ),
              VariableOption(
                id: 4,
                display: '> 110 mg/dL',
                displays: ['> 110 mg/dL', '> 6.1 mmol/L'],
                value: 1,
              ),
            ],
          ),
        ],
      ),
    ],
  ),

  // ─── APACHE II ──────────────────────────────────────────────────────────────
  Score(
    id: 3,
    name: 'apache-ii',
    display: 'APACHE II',
    description:
        'Acute Physiology And Chronic Health Evaluation II. '
        'Schätzt die Krankenhausmortalität anhand von 17 klinischen Parametern '
        '(akute Physiologie, Alter, Vorerkrankungen).',
    groups: [
      Group(
        id: 1,
        name: 'akute_physiologie',
        display: 'Akute Physiologie (APS)',
        description:
            'Schlechteste Werte innerhalb der ersten 24 Stunden auf der Intensivstation.',
        items: [
          VariableSelection(
            id: 1,
            name: 'temperatur',
            display: 'Temperatur (rektal)',
            type: VariableType.select,
            units: Units.temperature,
            options: [
              VariableOption(
                id: 1,
                display: '≥ 41 °C',
                displays: ['≥ 41 °C', '≥ 105,8 °F'],
                value: 4,
              ),
              VariableOption(
                id: 2,
                display: '39 – 40,9 °C',
                displays: ['39 – 40,9 °C', '102,2 – 105,6 °F'],
                value: 3,
              ),
              VariableOption(
                id: 3,
                display: '38,5 – 38,9 °C',
                displays: ['38,5 – 38,9 °C', '101,3 – 102,0 °F'],
                value: 1,
              ),
              VariableOption(
                id: 4,
                display: '36 – 38,4 °C',
                displays: ['36 – 38,4 °C', '96,8 – 101,1 °F'],
                value: 0,
              ),
              VariableOption(
                id: 5,
                display: '34 – 35,9 °C',
                displays: ['34 – 35,9 °C', '93,2 – 96,6 °F'],
                value: 1,
              ),
              VariableOption(
                id: 6,
                display: '32 – 33,9 °C',
                displays: ['32 – 33,9 °C', '89,6 – 93,0 °F'],
                value: 2,
              ),
              VariableOption(
                id: 7,
                display: '30 – 31,9 °C',
                displays: ['30 – 31,9 °C', '86,0 – 89,4 °F'],
                value: 3,
              ),
              VariableOption(
                id: 8,
                display: '< 30 °C',
                displays: ['< 30 °C', '< 86,0 °F'],
                value: 4,
              ),
            ],
          ),
          VariableSelection(
            id: 2,
            name: 'map',
            display: 'Mittlerer Arteriendruck',
            description: 'MAP = (Systole + 2 × Diastole) / 3, in mmHg.',
            type: VariableType.select,
            options: [
              VariableOption(id: 1, display: '≥ 160 mmHg', value: 4),
              VariableOption(id: 2, display: '130 – 159 mmHg', value: 3),
              VariableOption(id: 3, display: '110 – 129 mmHg', value: 2),
              VariableOption(id: 4, display: '70 – 109 mmHg', value: 0),
              VariableOption(id: 5, display: '50 – 69 mmHg', value: 2),
              VariableOption(id: 6, display: '< 50 mmHg', value: 4),
            ],
          ),
          VariableSelection(
            id: 3,
            name: 'herzfrequenz',
            display: 'Herzfrequenz',
            description: 'Herzfrequenz in Schlägen/min.',
            type: VariableType.select,
            options: [
              VariableOption(id: 1, display: '≥ 180 /min', value: 4),
              VariableOption(id: 2, display: '140 – 179 /min', value: 3),
              VariableOption(id: 3, display: '110 – 139 /min', value: 2),
              VariableOption(id: 4, display: '70 – 109 /min', value: 0),
              VariableOption(id: 5, display: '55 – 69 /min', value: 2),
              VariableOption(id: 6, display: '40 – 54 /min', value: 3),
              VariableOption(id: 7, display: '< 40 /min', value: 4),
            ],
          ),
          VariableSelection(
            id: 4,
            name: 'atemfrequenz',
            display: 'Atemfrequenz',
            description: 'Atemfrequenz in Zügen/min (spontan oder beatmet).',
            type: VariableType.select,
            options: [
              VariableOption(id: 1, display: '≥ 50 /min', value: 4),
              VariableOption(id: 2, display: '35 – 49 /min', value: 3),
              VariableOption(id: 3, display: '25 – 34 /min', value: 1),
              VariableOption(id: 4, display: '12 – 24 /min', value: 0),
              VariableOption(id: 5, display: '10 – 11 /min', value: 1),
              VariableOption(id: 6, display: '6 – 9 /min', value: 2),
              VariableOption(id: 7, display: '< 6 /min', value: 4),
            ],
          ),
          VariableBool(
            id: 5,
            name: 'fio2_hoch',
            display: 'FiO₂ ≥ 50 %',
            description: 'Ja → A-aDO₂ verwenden. Nein → PaO₂ verwenden.',
            value: null,
            trueValue: 0,
            falseValue: 0,
          ),
          VariableSelection(
            id: 6,
            name: 'aado2',
            display: 'A-aDO₂',
            description:
                'Alveolo-arterielle Sauerstoffdifferenz (nur bei FiO₂ ≥ 50 %).',
            type: VariableType.select,
            units: Units.pressure,
            options: [
              VariableOption(
                id: 1,
                display: '≥ 500 mmHg',
                displays: ['≥ 500 mmHg', '≥ 66,7 kPa'],
                value: 4,
              ),
              VariableOption(
                id: 2,
                display: '350 – 499 mmHg',
                displays: ['350 – 499 mmHg', '46,7 – 66,5 kPa'],
                value: 3,
              ),
              VariableOption(
                id: 3,
                display: '200 – 349 mmHg',
                displays: ['200 – 349 mmHg', '26,7 – 46,5 kPa'],
                value: 2,
              ),
              VariableOption(
                id: 4,
                display: '< 200 mmHg',
                displays: ['< 200 mmHg', '< 26,7 kPa'],
                value: 0,
              ),
            ],
          ),
          VariableSelection(
            id: 7,
            name: 'pao2',
            display: 'PaO₂',
            description:
                'Arterieller Sauerstoffpartialdruck (nur bei FiO₂ < 50 %).',
            type: VariableType.select,
            units: Units.pressure,
            options: [
              VariableOption(
                id: 1,
                display: '> 70 mmHg',
                displays: ['> 70 mmHg', '> 9,3 kPa'],
                value: 0,
              ),
              VariableOption(
                id: 2,
                display: '61 – 70 mmHg',
                displays: ['61 – 70 mmHg', '8,1 – 9,3 kPa'],
                value: 1,
              ),
              VariableOption(
                id: 3,
                display: '55 – 60 mmHg',
                displays: ['55 – 60 mmHg', '7,3 – 8,0 kPa'],
                value: 3,
              ),
              VariableOption(
                id: 4,
                display: '< 55 mmHg',
                displays: ['< 55 mmHg', '< 7,3 kPa'],
                value: 4,
              ),
            ],
          ),
          VariableSelection(
            id: 8,
            name: 'ph_arteriell',
            display: 'Arterieller pH',
            description: 'Arterieller pH aus der Blutgasanalyse.',
            type: VariableType.select,
            options: [
              VariableOption(id: 1, display: '≥ 7,70', value: 4),
              VariableOption(id: 2, display: '7,60 – 7,69', value: 3),
              VariableOption(id: 3, display: '7,50 – 7,59', value: 1),
              VariableOption(id: 4, display: '7,33 – 7,49', value: 0),
              VariableOption(id: 5, display: '7,25 – 7,32', value: 2),
              VariableOption(id: 6, display: '7,15 – 7,24', value: 3),
              VariableOption(id: 7, display: '< 7,15', value: 4),
            ],
          ),
          VariableSelection(
            id: 9,
            name: 'natrium',
            display: 'Serum-Natrium',
            description: 'Serumnatrium in mmol/L.',
            type: VariableType.select,
            options: [
              VariableOption(id: 1, display: '≥ 180 mmol/L', value: 4),
              VariableOption(id: 2, display: '160 – 179 mmol/L', value: 3),
              VariableOption(id: 3, display: '155 – 159 mmol/L', value: 2),
              VariableOption(id: 4, display: '150 – 154 mmol/L', value: 1),
              VariableOption(id: 5, display: '130 – 149 mmol/L', value: 0),
              VariableOption(id: 6, display: '120 – 129 mmol/L', value: 2),
              VariableOption(id: 7, display: '111 – 119 mmol/L', value: 3),
              VariableOption(id: 8, display: '≤ 110 mmol/L', value: 4),
            ],
          ),
          VariableSelection(
            id: 10,
            name: 'kalium',
            display: 'Serum-Kalium',
            description: 'Serumkalium in mmol/L.',
            type: VariableType.select,
            options: [
              VariableOption(id: 1, display: '≥ 7,0 mmol/L', value: 4),
              VariableOption(id: 2, display: '6,0 – 6,9 mmol/L', value: 3),
              VariableOption(id: 3, display: '5,5 – 5,9 mmol/L', value: 1),
              VariableOption(id: 4, display: '3,5 – 5,4 mmol/L', value: 0),
              VariableOption(id: 5, display: '3,0 – 3,4 mmol/L', value: 1),
              VariableOption(id: 6, display: '2,5 – 2,9 mmol/L', value: 2),
              VariableOption(id: 7, display: '< 2,5 mmol/L', value: 4),
            ],
          ),
          VariableSelection(
            id: 11,
            name: 'kreatinin',
            display: 'Serum-Kreatinin',
            description:
                'Serumkreatinin. Bei akutem Nierenversagen wird der Subscore verdoppelt.',
            type: VariableType.select,
            units: Units.creatinine,
            options: [
              VariableOption(
                id: 1,
                display: '≥ 3,5 mg/dL',
                displays: ['≥ 3,5 mg/dL', '≥ 309 µmol/L'],
                value: 4,
              ),
              VariableOption(
                id: 2,
                display: '2,0 – 3,4 mg/dL',
                displays: ['2,0 – 3,4 mg/dL', '177 – 301 µmol/L'],
                value: 3,
              ),
              VariableOption(
                id: 3,
                display: '1,5 – 1,9 mg/dL',
                displays: ['1,5 – 1,9 mg/dL', '133 – 168 µmol/L'],
                value: 2,
              ),
              VariableOption(
                id: 4,
                display: '0,6 – 1,4 mg/dL',
                displays: ['0,6 – 1,4 mg/dL', '53 – 124 µmol/L'],
                value: 0,
              ),
              VariableOption(
                id: 5,
                display: '< 0,6 mg/dL',
                displays: ['< 0,6 mg/dL', '< 53 µmol/L'],
                value: 2,
              ),
            ],
          ),
          VariableBool(
            id: 12,
            name: 'arf',
            display: 'Akutes Nierenversagen',
            description:
                'Liegt ein akutes Nierenversagen vor? '
                'Ja → Kreatinin-Subscore wird verdoppelt.',
            value: null,
            trueValue: 0,
            falseValue: 0,
          ),
          VariableSelection(
            id: 13,
            name: 'haematokrit',
            display: 'Hämatokrit',
            description: 'Hämatokrit in %.',
            type: VariableType.select,
            options: [
              VariableOption(id: 1, display: '≥ 60 %', value: 4),
              VariableOption(id: 2, display: '50 – 59,9 %', value: 2),
              VariableOption(id: 3, display: '46 – 49,9 %', value: 1),
              VariableOption(id: 4, display: '30 – 45,9 %', value: 0),
              VariableOption(id: 5, display: '20 – 29,9 %', value: 2),
              VariableOption(id: 6, display: '< 20 %', value: 4),
            ],
          ),
          VariableSelection(
            id: 14,
            name: 'leukozyten',
            display: 'Leukozyten',
            description: 'Leukozytenzahl.',
            type: VariableType.select,
            units: Units.leukocytes,
            options: [
              VariableOption(
                id: 1,
                display: '≥ 40 ×10³/µL',
                displays: ['≥ 40 ×10³/µL', '≥ 40 ×10⁹/L'],
                value: 4,
              ),
              VariableOption(
                id: 2,
                display: '20 – 39,9 ×10³/µL',
                displays: ['20 – 39,9 ×10³/µL', '20 – 39,9 ×10⁹/L'],
                value: 2,
              ),
              VariableOption(
                id: 3,
                display: '15 – 19,9 ×10³/µL',
                displays: ['15 – 19,9 ×10³/µL', '15 – 19,9 ×10⁹/L'],
                value: 1,
              ),
              VariableOption(
                id: 4,
                display: '3 – 14,9 ×10³/µL',
                displays: ['3 – 14,9 ×10³/µL', '3 – 14,9 ×10⁹/L'],
                value: 0,
              ),
              VariableOption(
                id: 5,
                display: '1 – 2,9 ×10³/µL',
                displays: ['1 – 2,9 ×10³/µL', '1 – 2,9 ×10⁹/L'],
                value: 2,
              ),
              VariableOption(
                id: 6,
                display: '< 1 ×10³/µL',
                displays: ['< 1 ×10³/µL', '< 1 ×10⁹/L'],
                value: 4,
              ),
            ],
          ),
          VariableNumber(
            id: 15,
            name: 'gcs',
            display: 'Glasgow Coma Scale',
            description:
                'Aktueller GCS-Wert (3 – 15). APS-Subscore = 15 − GCS.',
            value: null,
            normMin: 3,
            normMax: 15,
          ),
        ],
      ),
      Group(
        id: 2,
        name: 'alter',
        display: 'Alter',
        description: 'Patientenalter in Jahren.',
        items: [
          VariableSelection(
            id: 16,
            name: 'alter',
            display: 'Alter',
            description: 'Patientenalter in Jahren.',
            type: VariableType.select,
            options: [
              VariableOption(id: 1, display: '≤ 44 Jahre', value: 0),
              VariableOption(id: 2, display: '45 – 54 Jahre', value: 2),
              VariableOption(id: 3, display: '55 – 64 Jahre', value: 3),
              VariableOption(id: 4, display: '65 – 74 Jahre', value: 5),
              VariableOption(id: 5, display: '≥ 75 Jahre', value: 6),
            ],
          ),
        ],
      ),
      Group(
        id: 3,
        name: 'vorerkrankungen',
        display: 'Chronische Erkrankungen',
        description:
            'Schwere Organinsuffizienz oder Immunsuppression vor der Aufnahme '
            '(Herz, Lunge, Leber, Niere, Immunsystem).',
        items: [
          VariableSelection(
            id: 17,
            name: 'vorerkrankungen',
            display: 'Chronische Erkrankungen / Immunsuppression',
            description: 'Wähle die zutreffende Kategorie aus.',
            type: VariableType.select,
            options: [
              VariableOption(
                id: 1,
                display: 'Keine schwerwiegenden Vorerkrankungen',
                value: 0,
              ),
              VariableOption(
                id: 2,
                display:
                    'Schwere Organinsuffizienz – elektiver postoperativer Patient',
                value: 2,
              ),
              VariableOption(
                id: 3,
                display:
                    'Schwere Organinsuffizienz – nicht-operativer oder Notfall-OP-Patient',
                value: 5,
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];

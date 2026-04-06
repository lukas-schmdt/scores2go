import 'package:scores_2_go/function/value_unit_converter.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_group.dart';
import 'package:scores_2_go/model/variable.dart';
import 'package:scores_2_go/model/variable_bool.dart';
import 'package:scores_2_go/model/variable_number.dart';
import 'package:scores_2_go/model/variable_selection.dart';

Score buildApacheIiScore() => Score(
  id: 3,
  name: 'apache-ii',
  display: 'APACHE II',
  description: 'Acute Physiology And Chronic Health Evaluation (APACHE) II',
  groups: [
    Group(
      name: 'apache-ii-aps',
      display: 'Akute Physiologie (APS)',
      description:
          'Schlechteste Werte innerhalb der ersten 24 Stunden auf der Intensivstation.',
      items: [
        VariableSelection(
          name: 'apache-ii-temperatur',
          display: 'Temperatur (rektal)',
          type: VariableType.select,
          units: Units.temperature,
          options: [
            VariableOption(
              display: '≥ 41 °C',
              displays: ['≥ 41 °C', '≥ 105,8 °F'],
              value: 4,
            ),
            VariableOption(
              display: '39 – 40,9 °C',
              displays: ['39 – 40,9 °C', '102,2 – 105,6 °F'],
              value: 3,
            ),
            VariableOption(
              display: '38,5 – 38,9 °C',
              displays: ['38,5 – 38,9 °C', '101,3 – 102,0 °F'],
              value: 1,
            ),
            VariableOption(
              display: '36 – 38,4 °C',
              displays: ['36 – 38,4 °C', '96,8 – 101,1 °F'],
              value: 0,
            ),
            VariableOption(
              display: '34 – 35,9 °C',
              displays: ['34 – 35,9 °C', '93,2 – 96,6 °F'],
              value: 1,
            ),
            VariableOption(
              display: '32 – 33,9 °C',
              displays: ['32 – 33,9 °C', '89,6 – 93,0 °F'],
              value: 2,
            ),
            VariableOption(
              display: '30 – 31,9 °C',
              displays: ['30 – 31,9 °C', '86,0 – 89,4 °F'],
              value: 3,
            ),
            VariableOption(
              display: '< 30 °C',
              displays: ['< 30 °C', '< 86,0 °F'],
              value: 4,
            ),
          ],
        ),
        VariableSelection(
          name: 'apache-ii-map',
          display: 'Mittlerer Arteriendruck',
          description: 'MAP = (Systole + 2 × Diastole) / 3, in mmHg.',
          type: VariableType.select,
          options: [
            VariableOption(display: '≥ 160 mmHg', value: 4),
            VariableOption(display: '130 – 159 mmHg', value: 3),
            VariableOption(display: '110 – 129 mmHg', value: 2),
            VariableOption(display: '70 – 109 mmHg', value: 0),
            VariableOption(display: '50 – 69 mmHg', value: 2),
            VariableOption(display: '< 50 mmHg', value: 4),
          ],
        ),
        VariableSelection(
          name: 'apache-ii-herzfrequenz',
          display: 'Herzfrequenz',
          description: 'Herzfrequenz in Schlägen/min.',
          type: VariableType.select,
          options: [
            VariableOption(display: '≥ 180 /min', value: 4),
            VariableOption(display: '140 – 179 /min', value: 3),
            VariableOption(display: '110 – 139 /min', value: 2),
            VariableOption(display: '70 – 109 /min', value: 0),
            VariableOption(display: '55 – 69 /min', value: 2),
            VariableOption(display: '40 – 54 /min', value: 3),
            VariableOption(display: '< 40 /min', value: 4),
          ],
        ),
        VariableSelection(
          name: 'apache-ii-atemfrequenz',
          display: 'Atemfrequenz',
          description: 'Atemfrequenz in Zügen/min (spontan oder beatmet).',
          type: VariableType.select,
          options: [
            VariableOption(display: '≥ 50 /min', value: 4),
            VariableOption(display: '35 – 49 /min', value: 3),
            VariableOption(display: '25 – 34 /min', value: 1),
            VariableOption(display: '12 – 24 /min', value: 0),
            VariableOption(display: '10 – 11 /min', value: 1),
            VariableOption(display: '6 – 9 /min', value: 2),
            VariableOption(display: '< 6 /min', value: 4),
          ],
        ),
        VariableBool(
          name: 'apache-ii-fio2_hoch',
          display: 'FiO₂ ≥ 50 %',
          description: 'Ja → A-aDO₂ verwenden. Nein → PaO₂ verwenden.',
          value: null,
          trueValue: 0,
          falseValue: 0,
        ),
        VariableSelection(
          name: 'apache-ii-aado2',
          display: 'A-aDO₂',
          description:
              'Alveolo-arterielle Sauerstoffdifferenz (nur bei FiO₂ ≥ 50 %).',
          type: VariableType.select,
          units: Units.pressure,
          options: [
            VariableOption(
              display: '≥ 500 mmHg',
              displays: ['≥ 500 mmHg', '≥ 66,7 kPa'],
              value: 4,
            ),
            VariableOption(
              display: '350 – 499 mmHg',
              displays: ['350 – 499 mmHg', '46,7 – 66,5 kPa'],
              value: 3,
            ),
            VariableOption(
              display: '200 – 349 mmHg',
              displays: ['200 – 349 mmHg', '26,7 – 46,5 kPa'],
              value: 2,
            ),
            VariableOption(
              display: '< 200 mmHg',
              displays: ['< 200 mmHg', '< 26,7 kPa'],
              value: 0,
            ),
          ],
        ),
        VariableSelection(
          name: 'apache-ii-pao2',
          display: 'PaO₂',
          description:
              'Arterieller Sauerstoffpartialdruck (nur bei FiO₂ < 50 %).',
          type: VariableType.select,
          units: Units.pressure,
          options: [
            VariableOption(
              display: '> 70 mmHg',
              displays: ['> 70 mmHg', '> 9,3 kPa'],
              value: 0,
            ),
            VariableOption(
              display: '61 – 70 mmHg',
              displays: ['61 – 70 mmHg', '8,1 – 9,3 kPa'],
              value: 1,
            ),
            VariableOption(
              display: '55 – 60 mmHg',
              displays: ['55 – 60 mmHg', '7,3 – 8,0 kPa'],
              value: 3,
            ),
            VariableOption(
              display: '< 55 mmHg',
              displays: ['< 55 mmHg', '< 7,3 kPa'],
              value: 4,
            ),
          ],
        ),
        VariableSelection(
          name: 'apache-ii-ph_arteriell',
          display: 'Arterieller pH',
          description: 'Arterieller pH aus der Blutgasanalyse.',
          type: VariableType.select,
          options: [
            VariableOption(display: '≥ 7,70', value: 4),
            VariableOption(display: '7,60 – 7,69', value: 3),
            VariableOption(display: '7,50 – 7,59', value: 1),
            VariableOption(display: '7,33 – 7,49', value: 0),
            VariableOption(display: '7,25 – 7,32', value: 2),
            VariableOption(display: '7,15 – 7,24', value: 3),
            VariableOption(display: '< 7,15', value: 4),
          ],
        ),
        VariableSelection(
          name: 'apache-ii-natrium',
          display: 'Serum-Natrium',
          description: 'Serumnatrium in mmol/L.',
          type: VariableType.select,
          options: [
            VariableOption(display: '≥ 180 mmol/L', value: 4),
            VariableOption(display: '160 – 179 mmol/L', value: 3),
            VariableOption(display: '155 – 159 mmol/L', value: 2),
            VariableOption(display: '150 – 154 mmol/L', value: 1),
            VariableOption(display: '130 – 149 mmol/L', value: 0),
            VariableOption(display: '120 – 129 mmol/L', value: 2),
            VariableOption(display: '111 – 119 mmol/L', value: 3),
            VariableOption(display: '≤ 110 mmol/L', value: 4),
          ],
        ),
        VariableSelection(
          name: 'apache-ii-kalium',
          display: 'Serum-Kalium',
          description: 'Serumkalium in mmol/L.',
          type: VariableType.select,
          options: [
            VariableOption(display: '≥ 7,0 mmol/L', value: 4),
            VariableOption(display: '6,0 – 6,9 mmol/L', value: 3),
            VariableOption(display: '5,5 – 5,9 mmol/L', value: 1),
            VariableOption(display: '3,5 – 5,4 mmol/L', value: 0),
            VariableOption(display: '3,0 – 3,4 mmol/L', value: 1),
            VariableOption(display: '2,5 – 2,9 mmol/L', value: 2),
            VariableOption(display: '< 2,5 mmol/L', value: 4),
          ],
        ),
        VariableSelection(
          name: 'apache-ii-kreatinin',
          display: 'Serum-Kreatinin',
          description:
              'Serumkreatinin. Bei akutem Nierenversagen wird der Subscore verdoppelt.',
          type: VariableType.select,
          units: Units.creatinine,
          options: [
            VariableOption(
              display: '≥ 3,5 mg/dL',
              displays: ['≥ 3,5 mg/dL', '≥ 309 µmol/L'],
              value: 4,
            ),
            VariableOption(
              display: '2,0 – 3,4 mg/dL',
              displays: ['2,0 – 3,4 mg/dL', '177 – 301 µmol/L'],
              value: 3,
            ),
            VariableOption(
              display: '1,5 – 1,9 mg/dL',
              displays: ['1,5 – 1,9 mg/dL', '133 – 168 µmol/L'],
              value: 2,
            ),
            VariableOption(
              display: '0,6 – 1,4 mg/dL',
              displays: ['0,6 – 1,4 mg/dL', '53 – 124 µmol/L'],
              value: 0,
            ),
            VariableOption(
              display: '< 0,6 mg/dL',
              displays: ['< 0,6 mg/dL', '< 53 µmol/L'],
              value: 2,
            ),
          ],
        ),
        VariableBool(
          name: 'apache-ii-arf',
          display: 'Akutes Nierenversagen',
          description:
              'Liegt ein akutes Nierenversagen vor? '
              'Ja → Kreatinin-Subscore wird verdoppelt.',
          value: null,
          trueValue: 0,
          falseValue: 0,
        ),
        VariableSelection(
          name: 'apache-ii-haematokrit',
          display: 'Hämatokrit',
          description: 'Hämatokrit in %.',
          type: VariableType.select,
          options: [
            VariableOption(display: '≥ 60 %', value: 4),
            VariableOption(display: '50 – 59,9 %', value: 2),
            VariableOption(display: '46 – 49,9 %', value: 1),
            VariableOption(display: '30 – 45,9 %', value: 0),
            VariableOption(display: '20 – 29,9 %', value: 2),
            VariableOption(display: '< 20 %', value: 4),
          ],
        ),
        VariableSelection(
          name: 'apache-ii-leukozyten',
          display: 'Leukozyten',
          description: 'Leukozytenzahl.',
          type: VariableType.select,
          units: Units.leukocytes,
          options: [
            VariableOption(
              display: '≥ 40 ×10³/µL',
              displays: ['≥ 40 ×10³/µL', '≥ 40 ×10⁹/L'],
              value: 4,
            ),
            VariableOption(
              display: '20 – 39,9 ×10³/µL',
              displays: ['20 – 39,9 ×10³/µL', '20 – 39,9 ×10⁹/L'],
              value: 2,
            ),
            VariableOption(
              display: '15 – 19,9 ×10³/µL',
              displays: ['15 – 19,9 ×10³/µL', '15 – 19,9 ×10⁹/L'],
              value: 1,
            ),
            VariableOption(
              display: '3 – 14,9 ×10³/µL',
              displays: ['3 – 14,9 ×10³/µL', '3 – 14,9 ×10⁹/L'],
              value: 0,
            ),
            VariableOption(
              display: '1 – 2,9 ×10³/µL',
              displays: ['1 – 2,9 ×10³/µL', '1 – 2,9 ×10⁹/L'],
              value: 2,
            ),
            VariableOption(
              display: '< 1 ×10³/µL',
              displays: ['< 1 ×10³/µL', '< 1 ×10⁹/L'],
              value: 4,
            ),
          ],
        ),
        VariableNumber(
          name: 'apache-ii-gcs',
          display: 'Glasgow Coma Scale',
          description: 'Aktueller GCS-Wert (3 – 15). APS-Subscore = 15 − GCS.',
          value: null,
          normMin: 3,
          normMax: 15,
        ),
      ],
    ),
    Group(
      name: 'apache-ii-alter',
      display: 'Alter',
      description: 'Patientenalter in Jahren.',
      items: [
        VariableSelection(
          name: 'apache-ii-alter',
          display: 'Alter',
          description: 'Patientenalter in Jahren.',
          type: VariableType.select,
          options: [
            VariableOption(display: '≤ 44 Jahre', value: 0),
            VariableOption(display: '45 – 54 Jahre', value: 2),
            VariableOption(display: '55 – 64 Jahre', value: 3),
            VariableOption(display: '65 – 74 Jahre', value: 5),
            VariableOption(display: '≥ 75 Jahre', value: 6),
          ],
        ),
      ],
    ),
    Group(
      name: 'apache-ii-vorerkrankungen',
      display: 'Chronische Erkrankungen',
      description:
          'Schwere Organinsuffizienz oder Immunsuppression vor der Aufnahme '
          '(Herz, Lunge, Leber, Niere, Immunsystem).',
      items: [
        VariableSelection(
          name: 'apache-ii-vorerkrankungen',
          display: 'Chronische Erkrankungen / Immunsuppression',
          description: 'Wähle die zutreffende Kategorie aus.',
          type: VariableType.select,
          options: [
            VariableOption(
              display: 'Keine schwerwiegenden Vorerkrankungen',
              value: 0,
            ),
            VariableOption(
              display:
                  'Schwere Organinsuffizienz – elektiver postoperativer Patient',
              value: 2,
            ),
            VariableOption(
              display:
                  'Schwere Organinsuffizienz – nicht-operativer oder Notfall-OP-Patient',
              value: 5,
            ),
          ],
        ),
      ],
    ),
  ],
);

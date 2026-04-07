import 'package:scores_2_go/function/value_unit_converter.dart';
import 'package:scores_2_go/model/model.dart';

Score buildSapsIiScore() => Score(
  id: 4,
  name: 'saps-ii',
  display: 'SAPS II',
  description: 'Simplified Acute Physiology Score (SAPS) II',
  groups: [
    Group(
      name: 'saps-ii-demografie_aufnahme',
      display: 'Demografie & Aufnahme',
      description: 'Alter, Art der Aufnahme und relevante Vorerkrankungen.',
      items: [
        VariableSelection(
          name: 'saps-ii-alter',
          display: 'Alter',
          description: 'Alter in Jahren.',
          type: VariableType.select,
          options: [
            VariableOption(display: '< 40 Jahre', value: 0),
            VariableOption(display: '40 – 59 Jahre', value: 7),
            VariableOption(display: '60 – 69 Jahre', value: 12),
            VariableOption(display: '70 – 74 Jahre', value: 15),
            VariableOption(display: '75 – 79 Jahre', value: 16),
            VariableOption(display: '≥ 80 Jahre', value: 18),
          ],
        ),
        VariableSelection(
          name: 'saps-ii-aufnahmeart',
          display: 'Art der Aufnahme',
          description: 'Geplante OP, ungeplante OP oder medizinische Aufnahme.',
          type: VariableType.select,
          options: [
            VariableOption(display: 'Geplante chirurgische Aufnahme', value: 0),
            VariableOption(display: 'Medizinische Aufnahme', value: 6),
            VariableOption(
              display: 'Ungeplante chirurgische Aufnahme',
              value: 8,
            ),
          ],
        ),
        VariableSelection(
          name: 'saps-ii-chronische_erkrankungen',
          display: 'Chronische Erkrankungen',
          description:
              'Wähle die zutreffende Kategorie mit dem höchsten SAPS-II-Gewicht.',
          type: VariableType.select,
          options: [
            VariableOption(display: 'Keine', value: 0),
            VariableOption(display: 'Metastasierendes Karzinom', value: 9),
            VariableOption(display: 'Hämatologische Malignität', value: 10),
            VariableOption(display: 'AIDS', value: 17),
          ],
        ),
      ],
    ),
    Group(
      name: 'saps-ii-vitalparameter',
      display: 'Vitalparameter',
      description:
          'Schlechteste bzw. relevanteste Werte innerhalb der ersten 24 Stunden.',
      items: [
        VariableSelection(
          name: 'saps-ii-herzfrequenz',
          display: 'Herzfrequenz',
          description: 'Worst value in den ersten 24 Stunden.',
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
          display: 'Systolischer Blutdruck',
          description: 'Worst value in mmHg.',
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
          display: 'Körpertemperatur',
          description: 'Höchste gemessene Temperatur.',
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
          display: 'Glasgow Coma Scale',
          description:
              'Niedrigster GCS; bei Sedierung den geschätzten präsedativen GCS verwenden.',
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
          display: 'Beatmung oder CPAP',
          description:
              'Nur wenn Ja, wird der PaO₂/FiO₂-Parameter berücksichtigt.',
          value: null,
          trueValue: 0,
          falseValue: 0,
        ),
        VariableSelection(
          name: 'saps-ii-pao2_fio2',
          display: 'PaO₂/FiO₂',
          description:
              'Nur bei Beatmung oder CPAP innerhalb der ersten 24 Stunden.',
          type: VariableType.select,
          options: [
            VariableOption(display: '< 100 mmHg', value: 11),
            VariableOption(display: '100 – 199 mmHg', value: 9),
            VariableOption(display: '≥ 200 mmHg', value: 6),
          ],
        ),
        VariableSelection(
          name: 'saps-ii-urinausscheidung',
          display: 'Urinausscheidung',
          description: 'Urinausscheidung hochgerechnet auf 24 Stunden.',
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
      display: 'Labor',
      description:
          'Schlechteste bzw. höchste/niedrigste relevante Laborwerte aus den ersten 24 Stunden.',
      items: [
        VariableSelection(
          name: 'saps-ii-bun',
          display: 'BUN / Harnstoffstickstoff',
          description:
              'Falls du später eine BUN-Unit-Conversion einbaust, kannst du hier Units.bun ergänzen.',
          type: VariableType.select,
          options: [
            VariableOption(display: '< 28 mg/dL', value: 0),
            VariableOption(display: '28 – 83 mg/dL', value: 6),
            VariableOption(display: '≥ 84 mg/dL', value: 10),
          ],
        ),
        VariableSelection(
          name: 'saps-ii-leukozyten',
          display: 'Leukozyten',
          description: 'Worst value.',
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
          display: 'Kalium',
          description: 'Worst value in mmol/L.',
          type: VariableType.select,
          options: [
            VariableOption(display: '< 3,0 mmol/L', value: 3),
            VariableOption(display: '3,0 – 4,9 mmol/L', value: 0),
            VariableOption(display: '≥ 5,0 mmol/L', value: 3),
          ],
        ),
        VariableSelection(
          name: 'saps-ii-natrium',
          display: 'Natrium',
          description: 'Worst value in mmol/L.',
          type: VariableType.select,
          options: [
            VariableOption(display: '< 125 mmol/L', value: 5),
            VariableOption(display: '125 – 144 mmol/L', value: 0),
            VariableOption(display: '≥ 145 mmol/L', value: 1),
          ],
        ),
        VariableSelection(
          name: 'saps-ii-bicarbonat',
          display: 'Bicarbonat',
          description: 'Niedrigster Wert in mmol/L bzw. mEq/L.',
          type: VariableType.select,
          options: [
            VariableOption(display: '< 15 mmol/L', value: 6),
            VariableOption(display: '15 – 19 mmol/L', value: 3),
            VariableOption(display: '≥ 20 mmol/L', value: 0),
          ],
        ),
        VariableSelection(
          name: 'saps-ii-bilirubin',
          display: 'Bilirubin',
          description:
              'Wenn du später eine Bilirubin-Unit-Conversion ergänzt, kannst du hier Units.bilirubin ergänzen.',
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

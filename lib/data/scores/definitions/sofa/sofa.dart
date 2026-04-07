import 'package:scores_2_go/function/value_unit_converter.dart';
import 'package:scores_2_go/model/model.dart';

Score buildSofaScore() => Score(
  id: 5,
  name: 'sofa',
  display: 'SOFA',
  description: 'Sequential Organ Failure Assessment (SOFA)',
  groups: [
    Group(
      name: 'sofa-respiration',
      display: 'Respiration',
      description:
          'Respiratorische Organdysfunktion anhand des PaO₂/FiO₂-Verhältnisses.',
      items: [
        VariableBool(
          name: 'sofa-respiratory_support',
          display: 'Respiratorische Unterstützung',
          description:
              'Erforderlich für die SOFA-Respirationsscores 3 und 4 '
              '(z. B. Beatmung/CPAP).',
          value: null,
          trueValue: 0,
          falseValue: 0,
        ),
        VariableSelection(
          name: 'sofa-pao2_fio2',
          display: 'PaO₂/FiO₂',
          description:
              'PaO₂/FiO₂-Verhältnis. Für Scores 3–4 nur bei respiratorischer Unterstützung.',
          type: VariableType.select,
          options: [
            VariableOption(display: '≥ 400 mmHg', value: 0),
            VariableOption(display: '< 400 mmHg', value: 1),
            VariableOption(display: '< 300 mmHg', value: 2),
            VariableOption(
              display: '< 200 mmHg + respiratorische Unterstützung',
              value: 3,
            ),
            VariableOption(
              display: '< 100 mmHg + respiratorische Unterstützung',
              value: 4,
            ),
          ],
        ),
      ],
    ),
    Group(
      name: 'sofa-coagulation',
      display: 'Koagulation',
      description: 'Koagulationsstörung anhand der Thrombozytenzahl.',
      items: [
        VariableSelection(
          name: 'sofa-platelets',
          display: 'Thrombozyten',
          description: 'Thrombozytenzahl.',
          type: VariableType.select,
          options: [
            VariableOption(display: '≥ 150 ×10³/µL', value: 0),
            VariableOption(display: '< 150 ×10³/µL', value: 1),
            VariableOption(display: '< 100 ×10³/µL', value: 2),
            VariableOption(display: '< 50 ×10³/µL', value: 3),
            VariableOption(display: '< 20 ×10³/µL', value: 4),
          ],
        ),
      ],
    ),
    Group(
      name: 'sofa-liver',
      display: 'Leber',
      description: 'Leberdysfunktion anhand des Bilirubins.',
      items: [
        VariableSelection(
          name: 'sofa-bilirubin',
          display: 'Bilirubin',
          description: 'Gesamtbilirubin.',
          type: VariableType.select,
          options: [
            VariableOption(display: '< 1,2 mg/dL', value: 0),
            VariableOption(display: '1,2 – 1,9 mg/dL', value: 1),
            VariableOption(display: '2,0 – 5,9 mg/dL', value: 2),
            VariableOption(display: '6,0 – 11,9 mg/dL', value: 3),
            VariableOption(display: '≥ 12,0 mg/dL', value: 4),
          ],
        ),
      ],
    ),
    Group(
      name: 'sofa-cardiovascular',
      display: 'Kardiovaskulär',
      description:
          'Kardiovaskuläre Dysfunktion anhand von MAP und Vasopressoren.',
      items: [
        VariableSelection(
          name: 'sofa-cardiovascular_status',
          display: 'Kardiovaskulärer Status',
          description:
              'Bei Vasopressoren gelten die klassischen SOFA-Dosisschwellen.',
          type: VariableType.select,
          options: [
            VariableOption(display: 'MAP ≥ 70 mmHg', value: 0),
            VariableOption(display: 'MAP < 70 mmHg', value: 1),
            VariableOption(
              display: 'Dopamin ≤ 5 µg/kg/min oder Dobutamin (jede Dosis)',
              value: 2,
            ),
            VariableOption(
              display:
                  'Dopamin > 5 bis ≤ 15 µg/kg/min oder Epinephrin ≤ 0,1 µg/kg/min oder Noradrenalin ≤ 0,1 µg/kg/min',
              value: 3,
            ),
            VariableOption(
              display:
                  'Dopamin > 15 µg/kg/min oder Epinephrin > 0,1 µg/kg/min oder Noradrenalin > 0,1 µg/kg/min',
              value: 4,
            ),
          ],
        ),
      ],
    ),
    Group(
      name: 'sofa-cns',
      display: 'ZNS',
      description: 'Neurologische Dysfunktion anhand der Glasgow Coma Scale.',
      items: [
        VariableSelection(
          name: 'sofa-gcs',
          display: 'Glasgow Coma Scale',
          description: 'Niedrigster relevanter GCS-Wert.',
          type: VariableType.select,
          options: [
            VariableOption(display: '15', value: 0),
            VariableOption(display: '13 – 14', value: 1),
            VariableOption(display: '10 – 12', value: 2),
            VariableOption(display: '6 – 9', value: 3),
            VariableOption(display: '< 6', value: 4),
          ],
        ),
      ],
    ),
    Group(
      name: 'sofa-renal',
      display: 'Niere',
      description:
          'Renale Dysfunktion anhand von Kreatinin oder Urinausscheidung.',
      items: [
        VariableSelection(
          name: 'sofa-creatinine',
          display: 'Kreatinin',
          description: 'Serumkreatinin.',
          type: VariableType.select,
          units: Units.creatinine,
          options: [
            VariableOption(
              display: '< 1,2 mg/dL',
              displays: ['< 1,2 mg/dL', '< 110 µmol/L'],
              value: 0,
            ),
            VariableOption(
              display: '1,2 – 1,9 mg/dL',
              displays: ['1,2 – 1,9 mg/dL', '110 – 170 µmol/L'],
              value: 1,
            ),
            VariableOption(
              display: '2,0 – 3,4 mg/dL',
              displays: ['2,0 – 3,4 mg/dL', '171 – 299 µmol/L'],
              value: 2,
            ),
            VariableOption(
              display: '3,5 – 4,9 mg/dL',
              displays: ['3,5 – 4,9 mg/dL', '300 – 440 µmol/L'],
              value: 3,
            ),
            VariableOption(
              display: '≥ 5,0 mg/dL',
              displays: ['≥ 5,0 mg/dL', '≥ 440 µmol/L'],
              value: 4,
            ),
          ],
        ),
        VariableSelection(
          name: 'sofa-urine_output',
          display: 'Urinausscheidung',
          description:
              'Alternative renale Bewertung anhand der Diurese. '
              'Der schlechtere der beiden Nierenscores zählt.',
          type: VariableType.select,
          options: [
            VariableOption(display: '≥ 500 mL/Tag', value: 0),
            VariableOption(display: '< 500 mL/Tag', value: 3),
            VariableOption(display: '< 200 mL/Tag', value: 4),
          ],
        ),
      ],
    ),
  ],
);

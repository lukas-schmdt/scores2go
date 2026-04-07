import 'package:scores_2_go/l10n/score_i10n.dart';

class SofaI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const Map<String, Map<String, String>> _strings = {
    'en': {
      'description': 'Sequential Organ Failure Assessment (SOFA)',
      // Groups
      'group.respiration': 'Respiration',
      'group.coagulation': 'Coagulation',
      'group.liver': 'Liver',
      'group.cardiovascular': 'Cardiovascular',
      'group.cns': 'CNS',
      'group.renal': 'Renal',
      // Group descriptions
      'group.respiration.description':
          'Respiratory organ dysfunction based on PaO₂/FiO₂ ratio.',
      'group.coagulation.description':
          'Coagulation disorder based on platelet count.',
      'group.liver.description': 'Liver dysfunction based on bilirubin.',
      'group.cardiovascular.description':
          'Cardiovascular dysfunction based on MAP and vasopressors.',
      'group.cns.description':
          'Neurological dysfunction based on Glasgow Coma Scale.',
      'group.renal.description':
          'Renal dysfunction based on creatinine or urine output.',
      // Variables
      'respiratory_support.display': 'Respiratory Support',
      'respiratory_support.description':
          'Required for SOFA respiratory scores 3 and 4 '
          '(e.g. ventilation/CPAP).',
      'pao2_fio2.display': 'PaO₂/FiO₂',
      'pao2_fio2.description':
          'PaO₂/FiO₂ ratio. For scores 3–4 only with respiratory support.',
      'pao2_fio2.opt.200_support': '< 200 mmHg + respiratory support',
      'pao2_fio2.opt.100_support': '< 100 mmHg + respiratory support',
      'platelets.display': 'Platelets',
      'platelets.description': 'Platelet count.',
      'bilirubin.display': 'Bilirubin',
      'bilirubin.description': 'Total bilirubin.',
      'cardiovascular_status.display': 'Cardiovascular Status',
      'cardiovascular_status.description':
          'Standard SOFA dose thresholds apply for vasopressors.',
      'cardiovascular_status.opt.map_low': 'MAP < 70 mmHg',
      'cardiovascular_status.opt.dopa_low':
          'Dopamine ≤ 5 µg/kg/min or dobutamine (any dose)',
      'cardiovascular_status.opt.dopa_mid':
          'Dopamine > 5–15 µg/kg/min or epinephrine ≤ 0.1 µg/kg/min or norepinephrine ≤ 0.1 µg/kg/min',
      'cardiovascular_status.opt.dopa_high':
          'Dopamine > 15 µg/kg/min or epinephrine > 0.1 µg/kg/min or norepinephrine > 0.1 µg/kg/min',
      'gcs.display': 'Glasgow Coma Scale',
      'gcs.description': 'Lowest relevant GCS value.',
      'creatinine.display': 'Creatinine',
      'creatinine.description': 'Serum creatinine.',
      'urine_output.display': 'Urine Output',
      'urine_output.description':
          'Alternative renal assessment based on diuresis. '
          'The worse of the two renal scores counts.',
      'urine_output.opt.lt500': '< 500 mL/day',
      'urine_output.opt.lt200': '< 200 mL/day',
    },
    'de': {
      'description': 'Sequential Organ Failure Assessment (SOFA)',
      // Groups
      'group.respiration': 'Atmung',
      'group.coagulation': 'Gerinnung',
      'group.liver': 'Leber',
      'group.cardiovascular': 'Kardiovaskulär',
      'group.cns': 'Zentralnervensystem',
      'group.renal': 'Niere',
      // Group descriptions
      'group.respiration.description':
          'Respiratorische Organdysfunktion anhand des PaO₂/FiO₂-Verhältnisses.',
      'group.coagulation.description':
          'Koagulationsstörung anhand der Thrombozytenzahl.',
      'group.liver.description': 'Leberdysfunktion anhand des Bilirubins.',
      'group.cardiovascular.description':
          'Kardiovaskuläre Dysfunktion anhand von MAP und Vasopressoren.',
      'group.cns.description':
          'Neurologische Dysfunktion anhand der Glasgow Coma Scale.',
      'group.renal.description':
          'Renale Dysfunktion anhand von Kreatinin oder Urinausscheidung.',
      // Variables
      'respiratory_support.display': 'Respiratorische Unterstützung',
      'respiratory_support.description':
          'Erforderlich für die SOFA-Respirationsscores 3 und 4 '
          '(z. B. Beatmung/CPAP).',
      'pao2_fio2.display': 'PaO₂/FiO₂',
      'pao2_fio2.description':
          'PaO₂/FiO₂-Verhältnis. Für Scores 3–4 nur bei respiratorischer Unterstützung.',
      'pao2_fio2.opt.200_support': '< 200 mmHg + respiratorische Unterstützung',
      'pao2_fio2.opt.100_support': '< 100 mmHg + respiratorische Unterstützung',
      'platelets.display': 'Thrombozyten',
      'platelets.description': 'Thrombozytenzahl.',
      'bilirubin.display': 'Bilirubin',
      'bilirubin.description': 'Gesamtbilirubin.',
      'cardiovascular_status.display': 'Kardiovaskulärer Status',
      'cardiovascular_status.description':
          'Bei Vasopressoren gelten die klassischen SOFA-Dosisschwellen.',
      'cardiovascular_status.opt.map_low': 'MAP < 70 mmHg',
      'cardiovascular_status.opt.dopa_low':
          'Dopamin ≤ 5 µg/kg/min oder Dobutamin (jede Dosis)',
      'cardiovascular_status.opt.dopa_mid':
          'Dopamin > 5 bis ≤ 15 µg/kg/min oder Epinephrin ≤ 0,1 µg/kg/min oder Noradrenalin ≤ 0,1 µg/kg/min',
      'cardiovascular_status.opt.dopa_high':
          'Dopamin > 15 µg/kg/min oder Epinephrin > 0,1 µg/kg/min oder Noradrenalin > 0,1 µg/kg/min',
      'gcs.display': 'Glasgow Coma Scale',
      'gcs.description': 'Niedrigster relevanter GCS-Wert.',
      'creatinine.display': 'Kreatinin',
      'creatinine.description': 'Serumkreatinin.',
      'urine_output.display': 'Urinausscheidung',
      'urine_output.description':
          'Alternative renale Bewertung anhand der Diurese. '
          'Der schlechtere der beiden Nierenscores zählt.',
      'urine_output.opt.lt500': '< 500 mL/Tag',
      'urine_output.opt.lt200': '< 200 mL/Tag',
    },
  };
}

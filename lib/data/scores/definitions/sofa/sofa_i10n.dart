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
          'Required for SOFA respiratory scores 3 and 4 (e.g. ventilation/'
          'CPAP). If set to "No", the respiratory sub-score is capped at 2 '
          'even if PaO₂/FiO₂ is lower.',
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
      // Calculation output
      'calc.incomplete':
          'Please fill in all required fields (renal: creatinine or urine output).',
      'calc.points': 'points',
      'calc.organSystems': 'Organ systems',
      'calc.abbrev.resp': 'Resp',
      'calc.abbrev.coag': 'Coag',
      'calc.abbrev.liver': 'Liver',
      'calc.abbrev.cardio': 'Cardio',
      'calc.abbrev.cns': 'CNS',
      'calc.abbrev.renal': 'Renal',
      'calc.risk.veryLow': 'Very low risk (SOFA 0–6, < 10 % mortality)',
      'calc.risk.low': 'Low–moderate risk (SOFA 7–9, ~15–20 % mortality)',
      'calc.risk.moderate': 'Moderate–high risk (SOFA 10–12, ~40–50 % mortality)',
      'calc.risk.elevated': 'High risk (SOFA 13–14, ~50–60 % mortality)',
      'calc.risk.high': 'Very high risk (SOFA ≥ 15, > 80 % mortality)',
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
          'Erforderlich für die SOFA-Respirationsscores 3 und 4 (z. B. '
          'Beatmung/CPAP). Bei "Nein" wird der Respirationsscore auf maximal '
          '2 begrenzt, auch wenn PaO₂/FiO₂ niedriger ist.',
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
      // Calculation output
      'calc.incomplete':
          'Bitte alle Pflichtfelder ausfüllen (Niere: Kreatinin oder Urin).',
      'calc.points': 'Punkte',
      'calc.organSystems': 'Organsysteme',
      'calc.abbrev.resp': 'Resp',
      'calc.abbrev.coag': 'Koag',
      'calc.abbrev.liver': 'Leber',
      'calc.abbrev.cardio': 'Kardio',
      'calc.abbrev.cns': 'ZNS',
      'calc.abbrev.renal': 'Niere',
      'calc.risk.veryLow': 'Sehr geringes Risiko (SOFA 0–6, < 10 % Mortalität)',
      'calc.risk.low': 'Gering-moderates Risiko (SOFA 7–9, ~15–20 % Mortalität)',
      'calc.risk.moderate': 'Moderat-hohes Risiko (SOFA 10–12, ~40–50 % Mortalität)',
      'calc.risk.elevated': 'Hohes Risiko (SOFA 13–14, ~50–60 % Mortalität)',
      'calc.risk.high': 'Sehr hohes Risiko (SOFA ≥ 15, > 80 % Mortalität)',
    },
  };
}

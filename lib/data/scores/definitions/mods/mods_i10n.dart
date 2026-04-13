import 'package:scores_2_go/l10n/score_i10n.dart';

class ModsI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'MODS',
      'description':
          'Multiple Organ Dysfunction Score — quantifies the severity of '
          'organ failure in ICU patients across six systems. Total 0–24.',

      // Respiratory
      'respiratory.group.display': 'Respiratory',
      'respiratory.group.description':
          'PaO₂/FiO₂ ratio (mmHg). Measure without PEEP correction.',
      'pf.display': 'PaO₂ / FiO₂ ratio',
      'pf.description': 'Select the ratio range observed.',
      'pf.0': '> 300 mmHg',
      'pf.1': '226–300 mmHg',
      'pf.2': '151–225 mmHg',
      'pf.3': '76–150 mmHg',
      'pf.4': '≤ 75 mmHg',

      // Renal
      'renal.group.display': 'Renal',
      'renal.group.description': 'Serum creatinine (without renal replacement therapy).',
      'creatinine.display': 'Creatinine',
      'creatinine.description': 'Select the serum creatinine range.',
      'creatinine.0': '≤ 100 µmol/L  (≤ 1.1 mg/dL)',
      'creatinine.1': '101–200 µmol/L  (1.2–2.3 mg/dL)',
      'creatinine.2': '201–350 µmol/L  (2.4–3.9 mg/dL)',
      'creatinine.3': '351–500 µmol/L  (4.0–5.7 mg/dL)',
      'creatinine.4': '> 500 µmol/L  (> 5.7 mg/dL)',

      // Hepatic
      'hepatic.group.display': 'Hepatic',
      'hepatic.group.description': 'Serum bilirubin.',
      'bilirubin.display': 'Bilirubin',
      'bilirubin.description': 'Select the serum bilirubin range.',
      'bilirubin.0': '≤ 20 µmol/L  (≤ 1.2 mg/dL)',
      'bilirubin.1': '21–60 µmol/L  (1.3–3.5 mg/dL)',
      'bilirubin.2': '61–120 µmol/L  (3.6–7.0 mg/dL)',
      'bilirubin.3': '121–240 µmol/L  (7.1–14.0 mg/dL)',
      'bilirubin.4': '> 240 µmol/L  (> 14.0 mg/dL)',

      // Cardiovascular
      'cardiovascular.group.display': 'Cardiovascular',
      'cardiovascular.group.description':
          'Pressure-Adjusted Heart Rate (PAR) = HR × CVP / MAP. '
          'Enter the three values and the score is calculated automatically.',
      'hr.display': 'Heart rate',
      'hr.description': 'Beats per minute.',
      'map.display': 'Mean arterial pressure (MAP)',
      'map.description': 'mmHg.',
      'cvp.display': 'CVP / Right atrial pressure',
      'cvp.description': 'mmHg.',

      // Hematologic
      'hematologic.group.display': 'Hematologic',
      'hematologic.group.description': 'Platelet count.',
      'platelets.display': 'Platelet count',
      'platelets.description': 'Select the platelet count range.',
      'platelets.0': '> 120 ×10³/µL',
      'platelets.1': '81–120 ×10³/µL',
      'platelets.2': '51–80 ×10³/µL',
      'platelets.3': '21–50 ×10³/µL',
      'platelets.4': '≤ 20 ×10³/µL',

      // Neurologic
      'neurologic.group.display': 'Neurologic',
      'neurologic.group.description': 'Glasgow Coma Scale (GCS) score.',
      'gcs.display': 'GCS',
      'gcs.description': 'Select the GCS total.',
      'gcs.0': '15',
      'gcs.1': '13–14',
      'gcs.2': '10–12',
      'gcs.3': '7–9',
      'gcs.4': '≤ 6',
    },
    'de': {
      'display': 'MODS',
      'description':
          'Multiple Organ Dysfunction Score — quantifiziert den Schweregrad '
          'des Organversagens bei Intensivpatienten (6 Systeme). Gesamt 0–24.',

      // Respiratory
      'respiratory.group.display': 'Respiratorisch',
      'respiratory.group.description':
          'PaO₂/FiO₂-Quotient (mmHg), ohne PEEP-Korrektur.',
      'pf.display': 'PaO₂ / FiO₂-Quotient',
      'pf.description': 'Passenden Wertebereich auswählen.',
      'pf.0': '> 300 mmHg',
      'pf.1': '226–300 mmHg',
      'pf.2': '151–225 mmHg',
      'pf.3': '76–150 mmHg',
      'pf.4': '≤ 75 mmHg',

      // Renal
      'renal.group.display': 'Renal',
      'renal.group.description': 'Serumkreatinin (ohne Nierenersatztherapie).',
      'creatinine.display': 'Kreatinin',
      'creatinine.description': 'Passenden Serumkreatinin-Bereich auswählen.',
      'creatinine.0': '≤ 100 µmol/L  (≤ 1,1 mg/dL)',
      'creatinine.1': '101–200 µmol/L  (1,2–2,3 mg/dL)',
      'creatinine.2': '201–350 µmol/L  (2,4–3,9 mg/dL)',
      'creatinine.3': '351–500 µmol/L  (4,0–5,7 mg/dL)',
      'creatinine.4': '> 500 µmol/L  (> 5,7 mg/dL)',

      // Hepatic
      'hepatic.group.display': 'Hepatisch',
      'hepatic.group.description': 'Serumbilirubin.',
      'bilirubin.display': 'Bilirubin',
      'bilirubin.description': 'Passenden Serumbilirubin-Bereich auswählen.',
      'bilirubin.0': '≤ 20 µmol/L  (≤ 1,2 mg/dL)',
      'bilirubin.1': '21–60 µmol/L  (1,3–3,5 mg/dL)',
      'bilirubin.2': '61–120 µmol/L  (3,6–7,0 mg/dL)',
      'bilirubin.3': '121–240 µmol/L  (7,1–14,0 mg/dL)',
      'bilirubin.4': '> 240 µmol/L  (> 14,0 mg/dL)',

      // Cardiovascular
      'cardiovascular.group.display': 'Kardiovaskulär',
      'cardiovascular.group.description':
          'Druckadjustierte Herzfrequenz (PAR) = HF × ZVD / MAP. '
          'Alle drei Werte eingeben – der Score wird automatisch berechnet.',
      'hr.display': 'Herzfrequenz',
      'hr.description': 'Schläge pro Minute.',
      'map.display': 'Mittlerer arterieller Druck (MAP)',
      'map.description': 'mmHg.',
      'cvp.display': 'ZVD / Rechtsatrialer Druck',
      'cvp.description': 'mmHg.',

      // Hematologic
      'hematologic.group.display': 'Hämatologisch',
      'hematologic.group.description': 'Thrombozytenzahl.',
      'platelets.display': 'Thrombozyten',
      'platelets.description': 'Passenden Thrombozytenbereich auswählen.',
      'platelets.0': '> 120 ×10³/µL',
      'platelets.1': '81–120 ×10³/µL',
      'platelets.2': '51–80 ×10³/µL',
      'platelets.3': '21–50 ×10³/µL',
      'platelets.4': '≤ 20 ×10³/µL',

      // Neurologic
      'neurologic.group.display': 'Neurologisch',
      'neurologic.group.description': 'Glasgow Coma Scale (GCS).',
      'gcs.display': 'GCS',
      'gcs.description': 'GCS-Gesamtpunktzahl auswählen.',
      'gcs.0': '15',
      'gcs.1': '13–14',
      'gcs.2': '10–12',
      'gcs.3': '7–9',
      'gcs.4': '≤ 6',
    },
  };
}

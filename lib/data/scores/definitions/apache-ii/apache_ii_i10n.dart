import 'package:scores_2_go/l10n/score_i10n.dart';

class ApacheIiI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const Map<String, Map<String, String>> _strings = {
    'en': {
      'description':
          'Acute Physiology And Chronic Health Evaluation (APACHE) II',
      // Groups
      'group.aps.display': 'Acute Physiology Score (APS)',
      'group.aps.description':
          'Worst values within the first 24 hours in the ICU.',
      'group.age.display': 'Age',
      'group.age.description': "Patient's age in years.",
      'group.chronic.display': 'Chronic Health',
      'group.chronic.description':
          'Severe organ insufficiency or immunosuppression prior to admission '
          '(heart, lungs, liver, kidneys, immune system).',
      // Variables
      'temperatur.display': 'Temperature (rectal)',
      'map.display': 'Mean Arterial Pressure',
      'map.description': 'MAP = (Systolic + 2 × Diastolic) / 3, in mmHg.',
      'herzfrequenz.display': 'Heart Rate',
      'herzfrequenz.description': 'Heart rate in beats/min.',
      'atemfrequenz.display': 'Respiratory Rate',
      'atemfrequenz.description':
          'Respiratory rate in breaths/min (spontaneous or ventilated).',
      'fio2_hoch.display': 'FiO₂ ≥ 50 %',
      'fio2_hoch.description': 'Yes → use A-aDO₂. No → use PaO₂.',
      'aado2.display': 'A-aDO₂',
      'aado2.description':
          'Alveolar-arterial oxygen difference (only when FiO₂ ≥ 50 %).',
      'pao2.display': 'PaO₂',
      'pao2.description':
          'Arterial oxygen partial pressure (only when FiO₂ < 50 %).',
      'ph_arteriell.display': 'Arterial pH',
      'ph_arteriell.description': 'Arterial pH from blood gas analysis.',
      'natrium.display': 'Serum Sodium',
      'natrium.description': 'Serum sodium in mmol/L.',
      'kalium.display': 'Serum Potassium',
      'kalium.description': 'Serum potassium in mmol/L.',
      'kreatinin.display': 'Serum Creatinine',
      'kreatinin.description':
          'Serum creatinine. Doubled if acute renal failure is present.',
      'arf.display': 'Acute Renal Failure',
      'arf.description':
          'Is acute renal failure present? '
          'Yes → creatinine subscore is doubled.',
      'haematokrit.display': 'Haematocrit',
      'haematokrit.description': 'Haematocrit in %.',
      'leukozyten.display': 'White Blood Cells',
      'leukozyten.description': 'White blood cell count.',
      'gcs.display': 'Glasgow Coma Scale',
      'gcs.description': 'Current GCS (3–15). APS subscore = 15 − GCS.',
      'alter.display': 'Age',
      'alter.description': "Patient's age in years.",
      // Age options
      'alter.opt.le44': '≤ 44 years',
      'alter.opt.45_54': '45–54 years',
      'alter.opt.55_64': '55–64 years',
      'alter.opt.65_74': '65–74 years',
      'alter.opt.ge75': '≥ 75 years',
      // Chronic health variable
      'vorerkrankungen.display': 'Chronic Disease / Immunosuppression',
      'vorerkrankungen.description': 'Select the applicable category.',
      'vorerkrankungen.opt.none': 'No significant chronic disease',
      'vorerkrankungen.opt.elective':
          'Severe organ insufficiency – elective postoperative patient',
      'vorerkrankungen.opt.nonelective':
          'Severe organ insufficiency – non-operative or emergency surgery patient',
      // Calculation output
      'calc.incomplete': 'Please fill in all required fields.',
      'calc.points': 'points',
      'calc.subscoresLabel': 'Subscores',
      'calc.subscoresAge': 'Age',
      'calc.subscoresChronic': 'Chronic health',
      'calc.risk.veryLow': 'Very low risk (~2 % hospital mortality)',
      'calc.risk.low': 'Low risk (~8 % hospital mortality)',
      'calc.risk.moderate': 'Moderate risk (~15 % hospital mortality)',
      'calc.risk.elevated': 'Elevated risk (~24 % hospital mortality)',
      'calc.risk.high': 'High risk (~40 % hospital mortality)',
      'calc.risk.veryHigh': 'Very high risk (~55 % hospital mortality)',
      'calc.risk.critical': 'Critical (~73 % hospital mortality)',
      'calc.risk.extremelyCritical':
          'Extremely critical (~85 % hospital mortality)',
    },
    'de': {
      'description':
          'Acute Physiology And Chronic Health Evaluation (APACHE) II',
      // Groups
      'group.aps.display': 'Akute Physiologie (APS)',
      'group.aps.description':
          'Schlechteste Werte innerhalb der ersten 24 Stunden auf der Intensivstation.',
      'group.age.display': 'Alter',
      'group.age.description': 'Patientenalter in Jahren.',
      'group.chronic.display': 'Chronische Erkrankungen',
      'group.chronic.description':
          'Schwere Organinsuffizienz oder Immunsuppression vor der Aufnahme '
          '(Herz, Lunge, Leber, Niere, Immunsystem).',
      // Variables
      'temperatur.display': 'Temperatur (rektal)',
      'map.display': 'Mittlerer Arteriendruck',
      'map.description': 'MAP = (Systole + 2 × Diastole) / 3, in mmHg.',
      'herzfrequenz.display': 'Herzfrequenz',
      'herzfrequenz.description': 'Herzfrequenz in Schlägen/min.',
      'atemfrequenz.display': 'Atemfrequenz',
      'atemfrequenz.description':
          'Atemfrequenz in Zügen/min (spontan oder beatmet).',
      'fio2_hoch.display': 'FiO₂ ≥ 50 %',
      'fio2_hoch.description': 'Ja → A-aDO₂ verwenden. Nein → PaO₂ verwenden.',
      'aado2.display': 'A-aDO₂',
      'aado2.description':
          'Alveolo-arterielle Sauerstoffdifferenz (nur bei FiO₂ ≥ 50 %).',
      'pao2.display': 'PaO₂',
      'pao2.description':
          'Arterieller Sauerstoffpartialdruck (nur bei FiO₂ < 50 %).',
      'ph_arteriell.display': 'Arterieller pH',
      'ph_arteriell.description': 'Arterieller pH aus der Blutgasanalyse.',
      'natrium.display': 'Serum-Natrium',
      'natrium.description': 'Serumnatrium in mmol/L.',
      'kalium.display': 'Serum-Kalium',
      'kalium.description': 'Serumkalium in mmol/L.',
      'kreatinin.display': 'Serum-Kreatinin',
      'kreatinin.description':
          'Serumkreatinin. Bei akutem Nierenversagen wird der Subscore verdoppelt.',
      'arf.display': 'Akutes Nierenversagen',
      'arf.description':
          'Liegt ein akutes Nierenversagen vor? '
          'Ja → Kreatinin-Subscore wird verdoppelt.',
      'haematokrit.display': 'Hämatokrit',
      'haematokrit.description': 'Hämatokrit in %.',
      'leukozyten.display': 'Leukozyten',
      'leukozyten.description': 'Leukozytenzahl.',
      'gcs.display': 'Glasgow Coma Scale',
      'gcs.description': 'Aktueller GCS-Wert (3–15). APS-Subscore = 15 − GCS.',
      'alter.display': 'Alter',
      'alter.description': 'Patientenalter in Jahren.',
      // Age options
      'alter.opt.le44': '≤ 44 Jahre',
      'alter.opt.45_54': '45–54 Jahre',
      'alter.opt.55_64': '55–64 Jahre',
      'alter.opt.65_74': '65–74 Jahre',
      'alter.opt.ge75': '≥ 75 Jahre',
      // Chronic health variable
      'vorerkrankungen.display': 'Chronische Erkrankungen / Immunsuppression',
      'vorerkrankungen.description': 'Wähle die zutreffende Kategorie aus.',
      'vorerkrankungen.opt.none': 'Keine schwerwiegenden Vorerkrankungen',
      'vorerkrankungen.opt.elective':
          'Schwere Organinsuffizienz – elektiver postoperativer Patient',
      'vorerkrankungen.opt.nonelective':
          'Schwere Organinsuffizienz – nicht-operativer oder Notfall-OP-Patient',
      // Calculation output
      'calc.incomplete': 'Bitte alle Pflichtfelder ausfüllen.',
      'calc.points': 'Punkte',
      'calc.subscoresLabel': 'Teilscores',
      'calc.subscoresAge': 'Alter',
      'calc.subscoresChronic': 'Vorerkrankungen',
      'calc.risk.veryLow': 'Sehr niedriges Risiko (~2 % Krankenhausmortalität)',
      'calc.risk.low': 'Niedriges Risiko (~8 % Krankenhausmortalität)',
      'calc.risk.moderate': 'Moderates Risiko (~15 % Krankenhausmortalität)',
      'calc.risk.elevated': 'Erhöhtes Risiko (~24 % Krankenhausmortalität)',
      'calc.risk.high': 'Hohes Risiko (~40 % Krankenhausmortalität)',
      'calc.risk.veryHigh': 'Sehr hohes Risiko (~55 % Krankenhausmortalität)',
      'calc.risk.critical': 'Kritisch (~73 % Krankenhausmortalität)',
      'calc.risk.extremelyCritical':
          'Extrem kritisch (~85 % Krankenhausmortalität)',
    },
  };
}

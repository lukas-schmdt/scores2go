import 'package:scores_2_go/l10n/score_i10n.dart';

class SapsIiI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const Map<String, Map<String, String>> _strings = {
    'en': {
      'description': 'Simplified Acute Physiology Score (SAPS) II',
      // Groups
      'group.demografie.display': 'Demographics & Admission',
      'group.demografie.description':
          'Age, type of admission and relevant comorbidities.',
      'group.vitals.display': 'Vital Parameters',
      'group.vitals.description':
          'Worst or most relevant values within the first 24 hours.',
      'group.labor.display': 'Laboratory',
      'group.labor.description':
          'Worst or most extreme laboratory values from the first 24 hours.',
      // Variables
      'alter.display': 'Age',
      'alter.description': 'Age in years.',
      'alter.opt.lt40': '< 40 years',
      'alter.opt.40_59': '40–59 years',
      'alter.opt.60_69': '60–69 years',
      'alter.opt.70_74': '70–74 years',
      'alter.opt.75_79': '75–79 years',
      'alter.opt.ge80': '≥ 80 years',
      'aufnahmeart.display': 'Type of Admission',
      'aufnahmeart.description':
          'Elective surgery, emergency surgery, or medical admission.',
      'aufnahmeart.opt.elective': 'Elective surgical admission',
      'aufnahmeart.opt.medical': 'Medical admission',
      'aufnahmeart.opt.emergency': 'Emergency surgical admission',
      'chronische_erkrankungen.display': 'Chronic Disease',
      'chronische_erkrankungen.description':
          'Select the applicable category with the highest SAPS-II weight.',
      'chronische_erkrankungen.opt.none': 'None',
      'chronische_erkrankungen.opt.metastatic': 'Metastatic carcinoma',
      'chronische_erkrankungen.opt.hematologic': 'Hematologic malignancy',
      'chronische_erkrankungen.opt.aids': 'AIDS',
      'herzfrequenz.display': 'Heart Rate',
      'herzfrequenz.description': 'Worst value in the first 24 hours.',
      'systolischer_blutdruck.display': 'Systolic Blood Pressure',
      'systolischer_blutdruck.description': 'Worst value in mmHg.',
      'temperatur.display': 'Body Temperature',
      'temperatur.description': 'Highest measured temperature.',
      'gcs.display': 'Glasgow Coma Scale',
      'gcs.description':
          'Lowest GCS; if sedated, use the estimated pre-sedation GCS.',
      'beatmet_oder_cpap.display': 'Ventilation or CPAP',
      'beatmet_oder_cpap.description':
          'Only if Yes, the PaO₂/FiO₂ parameter is included.',
      'pao2_fio2.display': 'PaO₂/FiO₂',
      'pao2_fio2.description':
          'Only if ventilated or on CPAP within the first 24 hours.',
      'urinausscheidung.display': 'Urine Output',
      'urinausscheidung.description': 'Urine output extrapolated to 24 hours.',
      'bun.display': 'BUN / Blood Urea Nitrogen',
      'bun.description': 'Blood urea nitrogen in mg/dL.',
      'leukozyten.display': 'White Blood Cells',
      'leukozyten.description': 'Worst value.',
      'kalium.display': 'Potassium',
      'kalium.description': 'Worst value in mmol/L.',
      'natrium.display': 'Sodium',
      'natrium.description': 'Worst value in mmol/L.',
      'bicarbonat.display': 'Bicarbonate',
      'bicarbonat.description': 'Lowest value in mmol/L or mEq/L.',
      'bilirubin.display': 'Bilirubin',
      'bilirubin.description': 'Total bilirubin.',
    },
    'de': {
      'description': 'Simplified Acute Physiology Score (SAPS) II',
      // Groups
      'group.demografie.display': 'Demografie & Aufnahme',
      'group.demografie.description':
          'Alter, Art der Aufnahme und relevante Vorerkrankungen.',
      'group.vitals.display': 'Vitalparameter',
      'group.vitals.description':
          'Schlechteste bzw. relevanteste Werte innerhalb der ersten 24 Stunden.',
      'group.labor.display': 'Labor',
      'group.labor.description':
          'Schlechteste bzw. höchste/niedrigste relevante Laborwerte aus den ersten 24 Stunden.',
      // Variables
      'alter.display': 'Alter',
      'alter.description': 'Alter in Jahren.',
      'alter.opt.lt40': '< 40 Jahre',
      'alter.opt.40_59': '40–59 Jahre',
      'alter.opt.60_69': '60–69 Jahre',
      'alter.opt.70_74': '70–74 Jahre',
      'alter.opt.75_79': '75–79 Jahre',
      'alter.opt.ge80': '≥ 80 Jahre',
      'aufnahmeart.display': 'Art der Aufnahme',
      'aufnahmeart.description':
          'Geplante OP, ungeplante OP oder medizinische Aufnahme.',
      'aufnahmeart.opt.elective': 'Geplante chirurgische Aufnahme',
      'aufnahmeart.opt.medical': 'Medizinische Aufnahme',
      'aufnahmeart.opt.emergency': 'Ungeplante chirurgische Aufnahme',
      'chronische_erkrankungen.display': 'Chronische Erkrankungen',
      'chronische_erkrankungen.description':
          'Wähle die zutreffende Kategorie mit dem höchsten SAPS-II-Gewicht.',
      'chronische_erkrankungen.opt.none': 'Keine',
      'chronische_erkrankungen.opt.metastatic': 'Metastasierendes Karzinom',
      'chronische_erkrankungen.opt.hematologic': 'Hämatologische Malignität',
      'chronische_erkrankungen.opt.aids': 'AIDS',
      'herzfrequenz.display': 'Herzfrequenz',
      'herzfrequenz.description': 'Worst value in den ersten 24 Stunden.',
      'systolischer_blutdruck.display': 'Systolischer Blutdruck',
      'systolischer_blutdruck.description': 'Worst value in mmHg.',
      'temperatur.display': 'Körpertemperatur',
      'temperatur.description': 'Höchste gemessene Temperatur.',
      'gcs.display': 'Glasgow Coma Scale',
      'gcs.description':
          'Niedrigster GCS; bei Sedierung den geschätzten präsedativen GCS verwenden.',
      'beatmet_oder_cpap.display': 'Beatmung oder CPAP',
      'beatmet_oder_cpap.description':
          'Nur wenn Ja, wird der PaO₂/FiO₂-Parameter berücksichtigt.',
      'pao2_fio2.display': 'PaO₂/FiO₂',
      'pao2_fio2.description':
          'Nur bei Beatmung oder CPAP innerhalb der ersten 24 Stunden.',
      'urinausscheidung.display': 'Urinausscheidung',
      'urinausscheidung.description':
          'Urinausscheidung hochgerechnet auf 24 Stunden.',
      'bun.display': 'BUN / Harnstoffstickstoff',
      'bun.description': 'Harnstoffstickstoff in mg/dL.',
      'leukozyten.display': 'Leukozyten',
      'leukozyten.description': 'Worst value.',
      'kalium.display': 'Kalium',
      'kalium.description': 'Worst value in mmol/L.',
      'natrium.display': 'Natrium',
      'natrium.description': 'Worst value in mmol/L.',
      'bicarbonat.display': 'Bicarbonat',
      'bicarbonat.description': 'Niedrigster Wert in mmol/L bzw. mEq/L.',
      'bilirubin.display': 'Bilirubin',
      'bilirubin.description': 'Gesamtbilirubin.',
    },
  };
}

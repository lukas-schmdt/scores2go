import 'package:scores_2_go/l10n/score_i10n.dart';

class DemoScoreI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const Map<String, Map<String, String>> _strings = {
    'en': {
      'display': 'Demo Score',
      'description':
          'Demonstration score covering all variable types: boolean, '
          'number, single-select, multi-select, and conditional activation.',
      // Groups
      'group.vitals.display': 'Vitals',
      'group.vitals.description': 'Core vital parameters.',
      'group.respiratory.display': 'Respiratory',
      'group.respiratory.description': 'Ventilation parameters.',
      'group.risk_factors.display': 'Risk Factors',
      'group.risk_factors.description': 'Select all applicable comorbidities.',
      // Variables
      'o2_therapy.display': 'Supplemental O₂',
      'o2_therapy.description': 'Is the patient receiving supplemental oxygen?',
      'temperature.display': 'Temperature',
      'temperature.description':
          'Body temperature. Tap the unit label to switch °C / °F.',
      'alertness.display': 'Alertness',
      'alertness.description': 'Level of consciousness.',
      'alertness.alert': 'Alert',
      'alertness.voice': 'Responds to voice',
      'alertness.unresponsive': 'Unresponsive',
      'ventilated.display': 'Mechanical Ventilation',
      'ventilated.description':
          'Is the patient on mechanical ventilation or CPAP?',
      'fio2.display': 'FiO₂',
      'fio2.description':
          'Fraction of inspired oxygen. Only shown when ventilated.',
      'comorbidities.display': 'Comorbidities',
      'comorbidities.description': 'All applicable conditions.',
      'comorbidities.diabetes': 'Diabetes',
      'comorbidities.copd': 'COPD',
      'comorbidities.ckd': 'Chronic kidney disease',
      'comorbidities.immuno': 'Immunosuppression',
      'blood_sugar.display': 'Blood Sugar',
      'blood_sugar.description': 'Tap the unit label to switch mg/dL ↔ mmol/L.',
    },
    'de': {
      'display': 'Demo Score',
      'description':
          'Demonstrations-Score mit allen Variablentypen: Boolean, '
          'Zahl, Einfachauswahl, Mehrfachauswahl und bedingter Anzeige.',
      // Groups
      'group.vitals.display': 'Vitalparameter',
      'group.vitals.description': 'Wesentliche Vitalparameter.',
      'group.respiratory.display': 'Atmung',
      'group.respiratory.description': 'Beatmungsparameter.',
      'group.risk_factors.display': 'Risikofaktoren',
      'group.risk_factors.description':
          'Alle zutreffenden Komorbiditäten auswählen.',
      // Variables
      'o2_therapy.display': 'Sauerstofftherapie',
      'o2_therapy.description': 'Erhält der Patient supplementären Sauerstoff?',
      'temperature.display': 'Temperatur',
      'temperature.description':
          'Körpertemperatur. Einheit durch Tippen wechseln: °C / °F.',
      'alertness.display': 'Vigilanz',
      'alertness.description': 'Bewusstseinslage.',
      'alertness.alert': 'Wach',
      'alertness.voice': 'Reagiert auf Ansprache',
      'alertness.unresponsive': 'Keine Reaktion',
      'ventilated.display': 'Maschinelle Beatmung',
      'ventilated.description':
          'Wird der Patient maschinell beatmet oder mit CPAP versorgt?',
      'fio2.display': 'FiO₂',
      'fio2.description':
          'Inspiratorische Sauerstofffraktion. Nur bei Beatmung sichtbar.',
      'comorbidities.display': 'Komorbiditäten',
      'comorbidities.description': 'Alle zutreffenden Erkrankungen.',
      'comorbidities.diabetes': 'Diabetes mellitus',
      'comorbidities.copd': 'COPD',
      'comorbidities.ckd': 'Chronische Nierenerkrankung',
      'comorbidities.immuno': 'Immunsuppression',
      'blood_sugar.display': 'Blutzucker',
      'blood_sugar.description':
          'Einheit durch Tippen wechseln: mg/dL ↔ mmol/L.',
    },
  };
}

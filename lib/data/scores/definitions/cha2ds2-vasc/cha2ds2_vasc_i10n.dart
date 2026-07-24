import 'package:scores_2_go/l10n/score_i10n.dart';

class Cha2ds2VascI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'CHA2DS2-VASc Score',
      'description':
          'Estimates annual ischemic stroke risk in patients with '
          'non-valvular atrial fibrillation from eight weighted clinical '
          'risk factors, guiding the decision to start oral '
          'anticoagulation.',

      'group.risk-factors.display': 'Risk Factors',
      'group.risk-factors.description':
          'Select the status of each risk factor.',

      'chf.display': 'Congestive Heart Failure / LV Dysfunction',
      'chf.description':
          'History of congestive heart failure or left ventricular '
          'systolic dysfunction.',

      'hypertension.display': 'Hypertension',
      'hypertension.description':
          'History of hypertension, treated or untreated.',

      'age.display': 'Age',
      'age.description': 'Patient age category.',
      'age.opt.lt65': '< 65 years',
      'age.opt.65_74': '65–74 years',
      'age.opt.ge75': '≥ 75 years',

      'diabetes.display': 'Diabetes Mellitus',
      'diabetes.description': 'History of diabetes mellitus.',

      'stroke-tia.display': 'Prior Stroke / TIA / Thromboembolism',
      'stroke-tia.description':
          'History of stroke, transient ischemic attack, or systemic '
          'thromboembolism.',

      'vascular-disease.display': 'Vascular Disease',
      'vascular-disease.description':
          'Prior myocardial infarction, peripheral arterial disease, or '
          'aortic plaque.',

      'sex.display': 'Sex',
      'sex.description': 'Biological sex.',
      'sex.opt.female': 'Female',
      'sex.opt.male': 'Male',
    },
    'de': {
      'display': 'CHA2DS2-VASc-Score',
      'description':
          'Schätzt das jährliche Schlaganfallrisiko bei Patienten mit '
          'nicht-valvulärem Vorhofflimmern anhand von acht gewichteten '
          'klinischen Risikofaktoren und unterstützt die Entscheidung zur '
          'oralen Antikoagulation.',

      'group.risk-factors.display': 'Risikofaktoren',
      'group.risk-factors.description':
          'Status jedes Risikofaktors auswählen.',

      'chf.display': 'Herzinsuffizienz / linksventrikuläre Dysfunktion',
      'chf.description':
          'Herzinsuffizienz in der Vorgeschichte oder linksventrikuläre '
          'systolische Dysfunktion.',

      'hypertension.display': 'Arterielle Hypertonie',
      'hypertension.description':
          'Arterielle Hypertonie in der Vorgeschichte, behandelt oder '
          'unbehandelt.',

      'age.display': 'Alter',
      'age.description': 'Alterskategorie des Patienten.',
      'age.opt.lt65': '< 65 Jahre',
      'age.opt.65_74': '65–74 Jahre',
      'age.opt.ge75': '≥ 75 Jahre',

      'diabetes.display': 'Diabetes mellitus',
      'diabetes.description': 'Diabetes mellitus in der Vorgeschichte.',

      'stroke-tia.display': 'Schlaganfall, TIA oder Thromboembolie',
      'stroke-tia.description':
          'Schlaganfall, TIA oder Thromboembolie in der Vorgeschichte.',

      'vascular-disease.display': 'Gefäßerkrankung',
      'vascular-disease.description':
          'Z. B. Myokardinfarkt, periphere arterielle Verschlusskrankheit '
          'oder Aortenplaque.',

      'sex.display': 'Geschlecht',
      'sex.description': 'Biologisches Geschlecht.',
      'sex.opt.female': 'Weiblich',
      'sex.opt.male': 'Männlich',
    },
  };
}

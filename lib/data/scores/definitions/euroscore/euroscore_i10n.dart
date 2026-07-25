import 'package:scores_2_go/l10n/score_i10n.dart';

class EuroscoreI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'EuroSCORE II',
      'description':
          'The European System for Cardiac Operative Risk Evaluation II '
          'predicts 30-day operative mortality for cardiac surgery.',
      // Groups
      'group.patient.display': 'Patient Factors',
      'group.patient.description': 'Patient demographics and comorbidities.',
      'group.cardiac.display': 'Cardiac Factors',
      'group.cardiac.description': 'Cardiac status and function.',
      'group.operation.display': 'Operation Factors',
      'group.operation.description': 'Procedure type, urgency and complexity.',
      // Patient factors
      'age.display': 'Age',
      'age.description':
          'Patient age in years. EuroSCORE II treats every age of 60 or '
          'below identically; each year above 60 adds further risk.',
      'female.display': 'Female sex',
      'female.description': 'Female patients carry an additional risk.',
      'renal_function.display': 'Renal function',
      'renal_function.description':
          'Creatinine clearance (Cockcroft-Gault): '
          'CrCl = ((140 − age) × weight[kg] × (0.85 if female)) / '
          '(72 × serum creatinine[mg/dL]).',
      'renal_function.gt85': 'Normal – CrCl > 85 mL/min',
      'renal_function.moderate': 'Moderate – CrCl 51–85 mL/min',
      'renal_function.severe': 'Severe – CrCl ≤ 50 mL/min (not on dialysis)',
      'renal_function.dialysis': 'On dialysis',
      'arteriopathy.display': 'Extracardiac arteriopathy',
      'arteriopathy.description':
          'Claudication, carotid occlusion/stenosis >50%, previous/planned '
          'aortic, limb or carotid intervention.',
      'poor_mobility.display': 'Poor mobility',
      'poor_mobility.description':
          'Severe impairment of mobility due to musculoskeletal or neurological dysfunction.',
      'prev_surgery.display': 'Previous cardiac surgery',
      'prev_surgery.description':
          'Previous cardiac surgery requiring opening of the pericardium.',
      'copd.display': 'Chronic lung disease',
      'copd.description':
          'Long-term use of bronchodilators or steroids for lung disease.',
      'endocarditis.display': 'Active endocarditis',
      'endocarditis.description':
          'Patient still on antibiotic treatment for endocarditis at time of surgery.',
      'critical_state.display': 'Critical preoperative state',
      'critical_state.description':
          'Ventricular tachycardia/fibrillation, preoperative cardiac massage, '
          'ventilation before anaesthesia, inotropic support, IABP, or acute renal failure.',
      'diabetes_insulin.display': 'Diabetes on insulin',
      'diabetes_insulin.description': 'Diabetes mellitus requiring insulin therapy.',
      'nyha.display': 'NYHA class',
      'nyha.description': 'New York Heart Association functional classification.',
      'nyha.1': 'NYHA I – No symptoms',
      'nyha.2': 'NYHA II – Symptoms with moderate exertion',
      'nyha.3': 'NYHA III – Symptoms with minimal exertion',
      'nyha.4': 'NYHA IV – Symptoms at rest',
      'ccs4.display': 'CCS class 4 angina',
      'ccs4.description': 'Canadian Cardiovascular Society class 4 angina at rest.',
      // Cardiac factors
      'lv_function.display': 'LV function (EF)',
      'lv_function.description': 'Left ventricular ejection fraction.',
      'lv_function.good': 'Good – EF > 50%',
      'lv_function.moderate': 'Moderate – EF 31–50%',
      'lv_function.poor': 'Poor – EF 21–30%',
      'lv_function.very_poor': 'Very poor – EF ≤ 20%',
      'recent_mi.display': 'Recent myocardial infarction',
      'recent_mi.description': 'MI within the last 90 days.',
      'pulm_htn.display': 'Pulmonary hypertension',
      'pulm_htn.description': 'Systolic pulmonary artery pressure.',
      'pulm_htn.no': 'No pulmonary hypertension',
      'pulm_htn.moderate': 'Moderate – PA systolic 31–55 mmHg',
      'pulm_htn.severe': 'Severe – PA systolic > 55 mmHg',
      // Operation factors
      'urgency.display': 'Urgency',
      'urgency.description': 'Timing of surgery.',
      'urgency.elective': 'Elective – Routine, no urgency',
      'urgency.urgent': 'Urgent – Not elective, done within days',
      'urgency.emergency': 'Emergency – Done before next working day',
      'urgency.salvage': 'Salvage – CPR en route to OR',
      'procedure.display': 'Weight of procedure',
      'procedure.description': 'Complexity of cardiac procedure.',
      'procedure.cabg': 'Isolated CABG',
      'procedure.single_non_cabg': 'Single non-CABG procedure',
      'procedure.two': '2 cardiac procedures',
      'procedure.three_plus': '3 or more cardiac procedures',
      'thoracic_aorta.display': 'Surgery on thoracic aorta',
      'thoracic_aorta.description':
          'Ascending, arch, or descending thoracic aorta surgery.',
      // Calculation output
      'calc.incomplete': 'Please fill in all required fields.',
      'calc.predicted30DayMortality': 'Predicted 30-day operative mortality',
      'calc.riskClass': 'Risk class',
      'calc.risk.low': 'Low risk (< 2 %)',
      'calc.risk.moderate': 'Moderate risk (2-5 %)',
      'calc.risk.high': 'High risk (5-10 %)',
      'calc.risk.veryHigh': 'Very high risk (> 10 %)',
    },
    'de': {
      'display': 'EuroSCORE II',
      'description':
          'Das European System for Cardiac Operative Risk Evaluation II '
          'schätzt die 30-Tage-Operationsmortalität bei Herzchirurgie.',
      'group.patient.display': 'Patientenfaktoren',
      'group.patient.description': 'Demografie und Komorbiditäten.',
      'group.cardiac.display': 'Kardiologische Faktoren',
      'group.cardiac.description': 'Herzfunktion und -status.',
      'group.operation.display': 'Operationsfaktoren',
      'group.operation.description': 'Eingriff, Dringlichkeit und Komplexität.',
      'age.display': 'Alter',
      'age.description':
          'Patientenalter in Jahren. EuroSCORE II behandelt jedes Alter von '
          '60 Jahren oder darunter gleich; jedes Jahr über 60 erhöht das Risiko weiter.',
      'female.display': 'Weibliches Geschlecht',
      'female.description': 'Weibliche Patienten tragen ein erhöhtes Risiko.',
      'renal_function.display': 'Nierenfunktion',
      'renal_function.description':
          'Kreatinin-Clearance (Cockcroft-Gault): '
          'CrCl = ((140 − Alter) × Gewicht[kg] × (0,85 bei Frauen)) / '
          '(72 × Serumkreatinin[mg/dL]).',
      'renal_function.gt85': 'Normal – CrCl > 85 mL/min',
      'renal_function.moderate': 'Mäßig – CrCl 51–85 mL/min',
      'renal_function.severe': 'Schwer – CrCl ≤ 50 mL/min (nicht dialysepflichtig)',
      'renal_function.dialysis': 'Dialysepflichtig',
      'arteriopathy.display': 'Extrakardiäre Arteriopathie',
      'arteriopathy.description':
          'Claudicatio, Karotisstenose/-verschluss > 50 %, frühere oder geplante '
          'Eingriffe an Aorta, Extremitäten oder Karotiden.',
      'poor_mobility.display': 'Eingeschränkte Mobilität',
      'poor_mobility.description':
          'Schwere Einschränkung durch muskuloskelettale oder neurologische Erkrankung.',
      'prev_surgery.display': 'Vorherige Herzoperation',
      'prev_surgery.description':
          'Frühere Herzoperation mit Perikardöffnung.',
      'copd.display': 'Chronische Lungenerkrankung',
      'copd.description':
          'Langzeitanwendung von Bronchodilatatoren oder Steroiden bei Lungenerkrankung.',
      'endocarditis.display': 'Aktive Endokarditis',
      'endocarditis.description':
          'Patient zum OP-Zeitpunkt noch unter Antibiotikatherapie wegen Endokarditis.',
      'critical_state.display': 'Kritischer präoperativer Zustand',
      'critical_state.description':
          'Ventrikuläre Tachykardie/Kammerflimmern, präoperative Herzdruckmassage, '
          'Beatmung vor Narkose, Katecholamine, IABP oder akutes Nierenversagen.',
      'diabetes_insulin.display': 'Insulin-pflichtiger Diabetes',
      'diabetes_insulin.description': 'Diabetes mellitus mit Insulintherapie.',
      'nyha.display': 'NYHA-Klasse',
      'nyha.description': 'Funktionsklasse der New York Heart Association.',
      'nyha.1': 'NYHA I – Keine Symptome',
      'nyha.2': 'NYHA II – Symptome bei mäßiger Belastung',
      'nyha.3': 'NYHA III – Symptome bei leichter Belastung',
      'nyha.4': 'NYHA IV – Symptome in Ruhe',
      'ccs4.display': 'CCS-Klasse 4 Angina pectoris',
      'ccs4.description': 'Angina pectoris in Ruhe (CCS IV).',
      'lv_function.display': 'LV-Funktion (EF)',
      'lv_function.description': 'Linksventrikuläre Ejektionsfraktion.',
      'lv_function.good': 'Gut – EF > 50 %',
      'lv_function.moderate': 'Mäßig – EF 31–50 %',
      'lv_function.poor': 'Schlecht – EF 21–30 %',
      'lv_function.very_poor': 'Sehr schlecht – EF ≤ 20 %',
      'recent_mi.display': 'Kürzlicher Herzinfarkt',
      'recent_mi.description': 'Myokardinfarkt in den letzten 90 Tagen.',
      'pulm_htn.display': 'Pulmonale Hypertonie',
      'pulm_htn.description': 'Systolischer Pulmonalarteriendruck.',
      'pulm_htn.no': 'Keine pulmonale Hypertonie',
      'pulm_htn.moderate': 'Mäßig – PA-Druck systolisch 31–55 mmHg',
      'pulm_htn.severe': 'Schwer – PA-Druck systolisch > 55 mmHg',
      'urgency.display': 'Dringlichkeit',
      'urgency.description': 'Zeitpunkt des Eingriffs.',
      'urgency.elective': 'Elektiv – Routineeingriff',
      'urgency.urgent': 'Dringlich – Innerhalb weniger Tage',
      'urgency.emergency': 'Notfall – Vor dem nächsten Werktag',
      'urgency.salvage': 'Salvage – Reanimation auf dem Weg in den OP',
      'procedure.display': 'Gewicht des Eingriffs',
      'procedure.description': 'Komplexität des herzchirurgischen Eingriffs.',
      'procedure.cabg': 'Isolierter Bypass (CABG)',
      'procedure.single_non_cabg': 'Einzel-Nicht-CABG-Eingriff',
      'procedure.two': '2 kardiale Eingriffe',
      'procedure.three_plus': '3 oder mehr kardiale Eingriffe',
      'thoracic_aorta.display': 'Eingriff an der thorakalen Aorta',
      'thoracic_aorta.description':
          'Eingriff an Aorta ascendens, Aortenbogen oder Aorta descendens.',
      // Calculation output
      'calc.incomplete': 'Bitte alle Pflichtfelder ausfüllen.',
      'calc.predicted30DayMortality': 'Vorhergesagte 30-Tage-Operationsmortalität',
      'calc.riskClass': 'Risikoklasse',
      'calc.risk.low': 'Niedriges Risiko (< 2 %)',
      'calc.risk.moderate': 'Mäßiges Risiko (2-5 %)',
      'calc.risk.high': 'Hohes Risiko (5-10 %)',
      'calc.risk.veryHigh': 'Sehr hohes Risiko (> 10 %)',
    },
  };
}

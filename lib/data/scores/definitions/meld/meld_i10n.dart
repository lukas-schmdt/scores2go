import 'package:scores_2_go/l10n/score_i10n.dart';

class MeldI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'MELD',
      'description':
          'Model for End-Stage Liver Disease — predicts 90-day mortality '
          'in patients with liver cirrhosis based on creatinine, bilirubin, and INR.',

      // Liver group
      'liver.group.display': 'Liver Function',
      'liver.group.description':
          'Total bilirubin reflects hepatocellular function.',
      'bilirubin.display': 'Bilirubin',
      'bilirubin.description': 'Total bilirubin. Values < 1.0 are floored to 1.0.',

      // Coagulation group
      'coagulation.group.display': 'Coagulation',
      'coagulation.group.description': 'INR reflects synthetic liver function.',
      'inr.display': 'INR',
      'inr.description': 'International Normalized Ratio. Values < 1.0 are floored to 1.0.',

      // Renal group
      'renal.group.display': 'Renal Function',
      'renal.group.description':
          'Creatinine is capped at 4.0 mg/dL. Dialysis patients are automatically assigned 4.0 mg/dL.',
      'creatinine.display': 'Creatinine',
      'creatinine.description':
          'Serum creatinine. Values < 1.0 are floored to 1.0; values > 4.0 are capped at 4.0.',
      'dialysis.display': 'Dialysis ≥ 2×/week',
      'dialysis.description':
          'Patient received dialysis at least twice in the preceding week. If yes, creatinine is set to 4.0 mg/dL.',
      // Calculation output
      'calc.incomplete.enterAll': 'Enter bilirubin, INR, and creatinine.',
      'calc.incomplete.allRequired': 'All three lab values are required.',
      'calc.mortality90day': '90-day mortality',
      'calc.risk.low': 'Low — MELD < 10',
      'calc.risk.moderate': 'Moderate — MELD 10–19',
      'calc.risk.high': 'High — MELD 20–29',
      'calc.risk.veryHigh': 'Very high — MELD ≥ 30',
    },
    'de': {
      'display': 'MELD',
      'description':
          'Model for End-Stage Liver Disease — schätzt die 90-Tage-Mortalität '
          'bei Leberzirrhose anhand von Kreatinin, Bilirubin und INR.',

      // Liver group
      'liver.group.display': 'Leberfunktion',
      'liver.group.description':
          'Gesamtbilirubin spiegelt die hepatozelluläre Funktion wider.',
      'bilirubin.display': 'Bilirubin',
      'bilirubin.description':
          'Gesamtbilirubin. Werte < 1,0 werden auf 1,0 gesetzt.',

      // Coagulation group
      'coagulation.group.display': 'Gerinnung',
      'coagulation.group.description':
          'Der INR spiegelt die synthetische Leberfunktion wider.',
      'inr.display': 'INR',
      'inr.description':
          'International Normalized Ratio. Werte < 1,0 werden auf 1,0 gesetzt.',

      // Renal group
      'renal.group.display': 'Nierenfunktion',
      'renal.group.description':
          'Kreatinin wird auf maximal 4,0 mg/dL begrenzt. Dialysepatienten erhalten automatisch 4,0 mg/dL.',
      'creatinine.display': 'Kreatinin',
      'creatinine.description':
          'Serumkreatinin. Werte < 1,0 werden auf 1,0 gesetzt; Werte > 4,0 auf 4,0 begrenzt.',
      'dialysis.display': 'Dialyse ≥ 2×/Woche',
      'dialysis.description':
          'Patient erhielt innerhalb der letzten Woche mindestens zweimal Dialyse. Falls ja, wird Kreatinin auf 4,0 mg/dL gesetzt.',
      // Calculation output
      'calc.incomplete.enterAll': 'Bilirubin, INR und Kreatinin eingeben.',
      'calc.incomplete.allRequired':
          'Alle drei Laborwerte sind erforderlich.',
      'calc.mortality90day': '90-Tage-Mortalität',
      'calc.risk.low': 'Niedrig — MELD < 10',
      'calc.risk.moderate': 'Moderat — MELD 10–19',
      'calc.risk.high': 'Hoch — MELD 20–29',
      'calc.risk.veryHigh': 'Sehr hoch — MELD ≥ 30',
    },
  };
}

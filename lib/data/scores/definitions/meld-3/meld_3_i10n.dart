import 'package:scores_2_go/l10n/score_i10n.dart';

class Meld3I10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'MELD 3.0',
      'description':
          'Model for End-Stage Liver Disease 3.0 — the OPTN/UNOS liver '
          'allocation standard since 13 July 2023. Adds a sex adjustment, '
          'serum sodium, and serum albumin to the classic MELD variables '
          'to correct the score\'s previous under-estimation of disease '
          'severity in female and low-muscle-mass candidates. For adults '
          '(≥ 18 years) only — OPTN uses a different, sex-term-free '
          'equation for candidates aged 12–17 that is not implemented here.',

      // Patient / sex group
      'sex.group.display': 'Patient',
      'sex.group.description':
          'OPTN defines this as the candidate\'s documented / legal sex, '
          'which may differ from sex assigned at birth.',
      'sex.display': 'Sex',
      'sex.description':
          'Documented/legal sex on the transplant record. Female adds a '
          'fixed +1.33 points to correct for the historical under-scoring '
          'of women under the original MELD equation.',
      'sex.opt.male': 'Male',
      'sex.opt.female': 'Female',

      // Liver group
      'liver.group.display': 'Liver Function',
      'liver.group.description':
          'Total bilirubin reflects hepatocellular function.',
      'bilirubin.display': 'Bilirubin',
      'bilirubin.description':
          'Total bilirubin. Values < 1.0 mg/dL are floored to 1.0 mg/dL. '
          'No upper cap.',

      // Coagulation group
      'coagulation.group.display': 'Coagulation',
      'coagulation.group.description':
          'INR reflects synthetic liver function.',
      'inr.display': 'INR',
      'inr.description':
          'International Normalized Ratio. Values < 1.0 are floored to '
          '1.0. No upper cap.',

      // Renal group
      'renal.group.display': 'Renal Function',
      'renal.group.description':
          'Creatinine is bounded to 1.0–3.0 mg/dL — note this ceiling is '
          '3.0 mg/dL, lower than the 4.0 mg/dL cap used in the original '
          'MELD. Dialysis patients are automatically assigned 3.0 mg/dL.',
      'creatinine.display': 'Creatinine',
      'creatinine.description':
          'Serum creatinine. Values < 1.0 mg/dL are floored to 1.0; '
          'values > 3.0 mg/dL are capped at 3.0.',
      'dialysis.display': 'Dialysis',
      'dialysis.description':
          '≥ 2 dialysis sessions in the preceding week, or ≥ 24 h of '
          'continuous veno-venous haemodialysis (CVVHD). If yes, '
          'creatinine is set to 3.0 mg/dL regardless of the entered lab '
          'value. Leaving this unanswered is treated as "no dialysis" and '
          'does not block calculation.',

      // Electrolytes group
      'electrolytes.group.display': 'Electrolytes',
      'electrolytes.group.description':
          'Hyponatraemia is an independent predictor of mortality on the '
          'transplant waiting list.',
      'sodium.display': 'Sodium',
      'sodium.description':
          'Serum sodium, bounded to 125–137 mmol/L. mEq/L and mmol/L are '
          'numerically identical for sodium.',

      // Nutrition group
      'nutrition.group.display': 'Nutrition',
      'nutrition.group.description':
          'Low albumin partly reflects reduced muscle mass and synthetic '
          'function, both of which bias creatinine-based estimates of '
          'renal function.',
      'albumin.display': 'Albumin',
      'albumin.description':
          'Serum albumin, bounded to 1.5–3.5 g/dL.',

      // Calculation output
      'calc.incomplete.allRequired':
          'Sex, bilirubin, INR, creatinine, sodium, and albumin are all '
          'required.',
      'calc.error.impossibleValues':
          'One or more entered values are physiologically impossible '
          '(bilirubin, INR, creatinine, and albumin must all be greater '
          'than zero).',
      'calc.mortality90day': '90-day mortality',
      'calc.risk.low': 'Low — MELD 3.0 < 10',
      'calc.risk.moderate': 'Moderate — MELD 3.0 10–19',
      'calc.risk.high': 'High — MELD 3.0 20–29',
      'calc.risk.veryHigh': 'Very high — MELD 3.0 ≥ 30',
    },
    'de': {
      // NOTE: German strings below are a reasonable machine-assisted
      // translation and have not yet been reviewed by a clinician /
      // native-speaking medical professional. Flag for clinical review
      // before relying on the exact wording.
      'display': 'MELD 3.0',
      'description':
          'Model for End-Stage Liver Disease 3.0 — seit dem 13. Juli 2023 '
          'der OPTN/UNOS-Standard für die Leberallokation. Ergänzt die '
          'klassischen MELD-Variablen um eine Geschlechtsanpassung, '
          'Serum-Natrium und Serum-Albumin, um die frühere '
          'Unterschätzung des Schweregrads bei weiblichen und '
          'muskelarmen Kandidat*innen zu korrigieren. Nur für '
          'Erwachsene (≥ 18 Jahre) — OPTN verwendet für Kandidat*innen '
          'im Alter von 12–17 Jahren eine andere, geschlechtsunabhängige '
          'Formel, die hier nicht implementiert ist.',

      // Patient / sex group
      'sex.group.display': 'Patient',
      'sex.group.description':
          'OPTN definiert dies als das dokumentierte/rechtliche '
          'Geschlecht auf der Transplantationsakte, das vom bei Geburt '
          'zugewiesenen Geschlecht abweichen kann.',
      'sex.display': 'Geschlecht',
      'sex.description':
          'Dokumentiertes/rechtliches Geschlecht auf der '
          'Transplantationsakte. „Weiblich" addiert fest +1,33 Punkte, '
          'um die historische Unterbewertung von Frauen durch die '
          'ursprüngliche MELD-Formel auszugleichen.',
      'sex.opt.male': 'Männlich',
      'sex.opt.female': 'Weiblich',

      // Liver group
      'liver.group.display': 'Leberfunktion',
      'liver.group.description':
          'Gesamtbilirubin spiegelt die hepatozelluläre Funktion wider.',
      'bilirubin.display': 'Bilirubin',
      'bilirubin.description':
          'Gesamtbilirubin. Werte < 1,0 mg/dL werden auf 1,0 mg/dL '
          'gesetzt. Keine Obergrenze.',

      // Coagulation group
      'coagulation.group.display': 'Gerinnung',
      'coagulation.group.description':
          'Der INR spiegelt die synthetische Leberfunktion wider.',
      'inr.display': 'INR',
      'inr.description':
          'International Normalized Ratio. Werte < 1,0 werden auf 1,0 '
          'gesetzt. Keine Obergrenze.',

      // Renal group
      'renal.group.display': 'Nierenfunktion',
      'renal.group.description':
          'Kreatinin wird auf 1,0–3,0 mg/dL begrenzt — diese Obergrenze '
          'liegt bei 3,0 mg/dL und damit niedriger als die 4,0-mg/dL-'
          'Grenze des ursprünglichen MELD. Dialysepatient*innen erhalten '
          'automatisch 3,0 mg/dL.',
      'creatinine.display': 'Kreatinin',
      'creatinine.description':
          'Serumkreatinin. Werte < 1,0 mg/dL werden auf 1,0 gesetzt; '
          'Werte > 3,0 mg/dL werden auf 3,0 begrenzt.',
      'dialysis.display': 'Dialyse',
      'dialysis.description':
          '≥ 2 Dialysesitzungen in der vorangegangenen Woche, oder '
          '≥ 24 h kontinuierliche veno-venöse Hämodialyse (CVVHD). Falls '
          'ja, wird Kreatinin unabhängig vom eingegebenen Laborwert auf '
          '3,0 mg/dL gesetzt. Wird diese Frage nicht beantwortet, wird '
          'dies als „keine Dialyse" gewertet und blockiert die '
          'Berechnung nicht.',

      // Electrolytes group
      'electrolytes.group.display': 'Elektrolyte',
      'electrolytes.group.description':
          'Hyponatriämie ist ein unabhängiger Prädiktor für Mortalität '
          'auf der Transplantationswarteliste.',
      'sodium.display': 'Natrium',
      'sodium.description':
          'Serum-Natrium, begrenzt auf 125–137 mmol/L. mEq/L und mmol/L '
          'sind für Natrium numerisch identisch.',

      // Nutrition group
      'nutrition.group.display': 'Ernährungsstatus',
      'nutrition.group.description':
          'Niedriges Albumin spiegelt teilweise eine verminderte '
          'Muskelmasse und Syntheseleistung wider, was beides '
          'kreatininbasierte Schätzungen der Nierenfunktion verzerrt.',
      'albumin.display': 'Albumin',
      'albumin.description':
          'Serumalbumin, begrenzt auf 1,5–3,5 g/dL.',

      // Calculation output
      'calc.incomplete.allRequired':
          'Geschlecht, Bilirubin, INR, Kreatinin, Natrium und Albumin '
          'sind alle erforderlich.',
      'calc.error.impossibleValues':
          'Ein oder mehrere eingegebene Werte sind physiologisch nicht '
          'möglich (Bilirubin, INR, Kreatinin und Albumin müssen alle '
          'größer als null sein).',
      'calc.mortality90day': '90-Tage-Mortalität',
      'calc.risk.low': 'Niedrig — MELD 3.0 < 10',
      'calc.risk.moderate': 'Moderat — MELD 3.0 10–19',
      'calc.risk.high': 'Hoch — MELD 3.0 20–29',
      'calc.risk.veryHigh': 'Sehr hoch — MELD 3.0 ≥ 30',
    },
  };
}

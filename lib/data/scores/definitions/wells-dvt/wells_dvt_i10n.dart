import 'package:scores_2_go/l10n/score_i10n.dart';

class WellsDvtI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'Wells Score (DVT)',
      'description':
          'Estimates the clinical pre-test probability of deep vein '
          'thrombosis in patients with suspected leg DVT, guiding the choice '
          'between D-dimer testing and compression ultrasound.',

      'group.criteria.display': 'Clinical Criteria',
      'group.criteria.description':
          'Only apply in patients in whom deep vein thrombosis of the leg is '
          'clinically suspected. Answer every criterion.',

      'cancer.display':
          'Active cancer (treatment ongoing, within 6 months, or palliative)',
      'cancer.description':
          'Cancer under treatment, treated within the last 6 months, or '
          'receiving palliative care.',

      'paralysis.display':
          'Paralysis, paresis or recent plaster immobilization of the lower '
          'extremity',
      'paralysis.description':
          'Applies to the lower extremity of the symptomatic side.',

      'bedridden-surgery.display':
          'Recently bedridden ≥ 3 days or major surgery within 12 weeks '
          '(general or regional anaesthesia)',
      'bedridden-surgery.description':
          'Bedridden for at least 3 days, or major surgery requiring general '
          'or regional anaesthesia within the previous 12 weeks.',

      'tenderness.display':
          'Localized tenderness along the distribution of the deep venous '
          'system',
      'tenderness.description':
          'Pain on palpation along the course of the deep veins.',

      'entire-leg-swollen.display': 'Entire leg swollen',
      'entire-leg-swollen.description':
          'Swelling of the whole symptomatic leg.',

      'calf-swelling.display':
          'Calf swelling ≥ 3 cm compared with asymptomatic side',
      'calf-swelling.description':
          'Measured 10 cm below the tibial tuberosity.',

      'pitting-edema.display': 'Pitting edema confined to the symptomatic leg',
      'pitting-edema.description':
          'Edema that leaves an indentation on pressure, limited to the '
          'symptomatic leg.',

      'collateral-veins.display': 'Collateral superficial veins (non-varicose)',
      'collateral-veins.description':
          'Dilated superficial collateral veins that are not varicose veins.',

      'previous-dvt.display': 'Previously documented DVT',
      'previous-dvt.description':
          'Prior deep vein thrombosis confirmed by objective testing.',

      'alternative-diagnosis.display':
          'Alternative diagnosis at least as likely as DVT',
      'alternative-diagnosis.description':
          'E.g. Baker cyst, cellulitis, muscle strain, post-thrombotic '
          'syndrome. Subtracts 2 points.',

      'calc.label': 'Wells Score (DVT)',
      'calc.incomplete': 'Please answer all criteria.',
      'calc.unlikely':
          'DVT unlikely (≤ 1 point). Perform D-dimer testing: a negative '
          'result excludes DVT, a positive result requires compression '
          'ultrasound.',
      'calc.likely':
          'DVT likely (≥ 2 points). Proceed directly to compression '
          'ultrasound. D-dimer alone should not be used to rule out DVT.',
      'calc.secondaryLabel': 'Three-tier probability',
      'calc.tier.low': 'Low',
      'calc.tier.moderate': 'Moderate',
      'calc.tier.high': 'High',
      'calc.tier.low.interp':
          '≤ 0 points: approx. 3% DVT prevalence in the original validation '
          'cohort (Wells 1997).',
      'calc.tier.moderate.interp':
          '1–2 points: approx. 17% DVT prevalence in the original validation '
          'cohort (Wells 1997).',
      'calc.tier.high.interp':
          '≥ 3 points: approx. 75% DVT prevalence in the original validation '
          'cohort (Wells 1997).',
    },
    // German translation: not clinically verified, flag for review.
    'de': {
      'display': 'Wells-Score (tiefe Beinvenenthrombose)',
      'description':
          'Schätzt die klinische Vortestwahrscheinlichkeit einer tiefen '
          'Beinvenenthrombose bei Verdacht und unterstützt die Wahl zwischen '
          'D-Dimer-Test und Kompressionssonographie.',

      'group.criteria.display': 'Klinische Kriterien',
      'group.criteria.description':
          'Nur anwenden, wenn klinisch der Verdacht auf eine tiefe '
          'Beinvenenthrombose besteht. Alle Kriterien beantworten.',

      'cancer.display':
          'Aktive Tumorerkrankung (Behandlung laufend, innerhalb der letzten '
          '6 Monate oder palliativ)',
      'cancer.description':
          'Tumorerkrankung unter Behandlung, behandelt innerhalb der letzten '
          '6 Monate oder palliative Situation.',

      'paralysis.display':
          'Lähmung, Parese oder kürzliche Gipsimmobilisation der unteren '
          'Extremität',
      'paralysis.description': 'Bezieht sich auf die symptomatische Seite.',

      'bedridden-surgery.display':
          'Bettlägerigkeit ≥ 3 Tage oder größere Operation innerhalb der '
          'letzten 12 Wochen',
      'bedridden-surgery.description':
          'Mindestens 3 Tage bettlägerig oder größere Operation in Allgemein- '
          'oder Regionalanästhesie innerhalb der letzten 12 Wochen.',

      'tenderness.display':
          'Lokalisierter Druckschmerz entlang des tiefen Venensystems',
      'tenderness.description':
          'Druckschmerz entlang des Verlaufs der tiefen Venen.',

      'entire-leg-swollen.display': 'Schwellung des gesamten Beins',
      'entire-leg-swollen.description':
          'Schwellung des gesamten symptomatischen Beins.',

      'calf-swelling.display':
          'Unterschenkelschwellung ≥ 3 cm im Vergleich zur Gegenseite',
      'calf-swelling.description':
          'Gemessen 10 cm unterhalb der Tuberositas tibiae.',

      'pitting-edema.display':
          'Eindrückbares Ödem, auf das symptomatische Bein beschränkt',
      'pitting-edema.description':
          'Ödem, das auf Druck eine Delle hinterlässt, beschränkt auf das '
          'symptomatische Bein.',

      'collateral-veins.display':
          'Kollaterale oberflächliche Venen (keine Varizen)',
      'collateral-veins.description':
          'Erweiterte oberflächliche Kollateralvenen, die keine Varizen sind.',

      'previous-dvt.display': 'Früher dokumentierte tiefe Beinvenenthrombose',
      'previous-dvt.description':
          'Frühere tiefe Beinvenenthrombose, objektiv gesichert.',

      'alternative-diagnosis.display':
          'Alternative Diagnose mindestens ebenso wahrscheinlich wie TVT',
      'alternative-diagnosis.description':
          'Z. B. Baker-Zyste, Erysipel/Phlegmone, Muskelzerrung, '
          'postthrombotisches Syndrom. Zieht 2 Punkte ab.',

      'calc.label': 'Wells-Score (TVT)',
      'calc.incomplete': 'Bitte alle Kriterien beantworten.',
      'calc.unlikely':
          'TVT unwahrscheinlich (≤ 1 Punkt). D-Dimer-Test durchführen: '
          'negativ schließt eine TVT aus, positiv erfordert eine '
          'Kompressionssonographie.',
      'calc.likely':
          'TVT wahrscheinlich (≥ 2 Punkte). Direkt Kompressionssonographie. '
          'Der D-Dimer-Test allein sollte nicht zum Ausschluss einer TVT '
          'verwendet werden.',
      'calc.secondaryLabel': 'Dreistufige Wahrscheinlichkeit',
      'calc.tier.low': 'Niedrig',
      'calc.tier.moderate': 'Mittel',
      'calc.tier.high': 'Hoch',
      'calc.tier.low.interp':
          '≤ 0 Punkte: ca. 3 % TVT-Prävalenz in der ursprünglichen '
          'Validierungskohorte (Wells 1997).',
      'calc.tier.moderate.interp':
          '1–2 Punkte: ca. 17 % TVT-Prävalenz in der ursprünglichen '
          'Validierungskohorte (Wells 1997).',
      'calc.tier.high.interp':
          '≥ 3 Punkte: ca. 75 % TVT-Prävalenz in der ursprünglichen '
          'Validierungskohorte (Wells 1997).',
    },
  };
}

import 'package:scores_2_go/l10n/score_i10n.dart';

class WellsPeI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'Wells Score (PE)',
      'description':
          'Estimates the pre-test probability of pulmonary embolism in '
          'patients with suspected PE from 7 clinical criteria, guiding the '
          'choice between D-dimer testing and CT pulmonary angiography.',

      'group.criteria.display': 'Clinical Criteria',
      'group.criteria.description':
          'Only apply in patients in whom pulmonary embolism is clinically '
          'suspected. Answer every criterion.',

      'dvt-signs.display': 'Clinical signs and symptoms of DVT',
      'dvt-signs.description':
          'Minimum: leg swelling and pain on palpation of the deep veins.',

      'pe-likely.display': 'PE is the #1 diagnosis or equally likely',

      'heart-rate.display': 'Heart rate > 100/min',

      'immobilization-surgery.display':
          'Immobilization ≥ 3 days or surgery in the previous 4 weeks',

      'previous-vte.display': 'Previous objectively diagnosed PE or DVT',

      'hemoptysis.display': 'Hemoptysis',

      'malignancy.display': 'Malignancy',
      'malignancy.description':
          'Treatment within the last 6 months, or palliative care.',

      'calc.label': 'Wells Score (PE)',
      'calc.incomplete': 'Please answer all criteria.',
      'calc.unlikely':
          'PE unlikely (≤ 4 points; approx. 12.1% PE prevalence in '
          'validation cohorts). Perform D-dimer testing (age-adjusted cutoff '
          'age × 10 µg/L in patients > 50 years): a negative result excludes '
          'PE, a positive result requires CT pulmonary angiography.',
      'calc.likely':
          'PE likely (> 4 points; approx. 37.1% PE prevalence in validation '
          'cohorts). Proceed directly to CT pulmonary angiography (V/Q scan '
          'if CTPA is contraindicated). D-dimer should not be used to rule '
          'out PE.',
      'calc.secondaryLabel': 'Three-tier probability',
      'calc.tier.low': 'Low',
      'calc.tier.moderate': 'Moderate',
      'calc.tier.high': 'High',
      'calc.tier.low.interp':
          '< 2 points: approx. 1.3% PE prevalence in validation cohorts.',
      'calc.tier.moderate.interp':
          '2–6 points: approx. 16.2% PE prevalence in validation cohorts.',
      'calc.tier.high.interp':
          '> 6 points: approx. 37.5% PE prevalence in validation cohorts.',
    },
    // German translation: not clinically verified, flag for review.
    'de': {
      'display': 'Wells-Score (Lungenembolie)',
      'description':
          'Schätzt anhand von 7 klinischen Kriterien die '
          'Vortestwahrscheinlichkeit einer Lungenembolie bei Verdacht auf LE '
          'und unterstützt die Entscheidung zwischen D-Dimer-Test und '
          'CT-Pulmonalisangiographie.',

      'group.criteria.display': 'Klinische Kriterien',
      'group.criteria.description':
          'Nur anwenden, wenn klinisch der Verdacht auf eine Lungenembolie '
          'besteht. Alle Kriterien beantworten.',

      'dvt-signs.display': 'Klinische Zeichen einer tiefen Beinvenenthrombose',
      'dvt-signs.description':
          'Mindestens Beinschwellung und Druckschmerz entlang der tiefen '
          'Venen.',

      'pe-likely.display':
          'Lungenembolie ist die wahrscheinlichste Diagnose oder gleich '
          'wahrscheinlich',

      'heart-rate.display': 'Herzfrequenz > 100/min',

      'immobilization-surgery.display':
          'Immobilisation ≥ 3 Tage oder Operation in den letzten 4 Wochen',

      'previous-vte.display':
          'Frühere, objektiv gesicherte Lungenembolie oder TVT',

      'hemoptysis.display': 'Hämoptyse',

      'malignancy.display': 'Malignom',
      'malignancy.description':
          'Behandlung innerhalb der letzten 6 Monate oder palliativ.',

      'calc.label': 'Wells-Score (Lungenembolie)',
      'calc.incomplete': 'Bitte alle Kriterien beantworten.',
      'calc.unlikely':
          'LE unwahrscheinlich (≤ 4 Punkte; ca. 12,1 % LE-Prävalenz in '
          'Validierungskohorten). D-Dimer-Test durchführen (altersadaptierter '
          'Grenzwert Alter × 10 µg/L bei Patienten > 50 Jahre): negativ '
          'schließt eine LE aus, positiv erfordert eine '
          'CT-Pulmonalisangiographie.',
      'calc.likely':
          'LE wahrscheinlich (> 4 Punkte; ca. 37,1 % LE-Prävalenz in '
          'Validierungskohorten). Direkt CT-Pulmonalisangiographie '
          '(V/Q-Szintigraphie bei Kontraindikation gegen CTPA). Der D-Dimer-'
          'Test sollte nicht zum Ausschluss einer LE verwendet werden.',
      'calc.secondaryLabel': 'Dreistufige Wahrscheinlichkeit',
      'calc.tier.low': 'Niedrig',
      'calc.tier.moderate': 'Mittel',
      'calc.tier.high': 'Hoch',
      'calc.tier.low.interp':
          '< 2 Punkte: ca. 1,3 % LE-Prävalenz in Validierungskohorten.',
      'calc.tier.moderate.interp':
          '2–6 Punkte: ca. 16,2 % LE-Prävalenz in Validierungskohorten.',
      'calc.tier.high.interp':
          '> 6 Punkte: ca. 37,5 % LE-Prävalenz in Validierungskohorten.',
    },
  };
}

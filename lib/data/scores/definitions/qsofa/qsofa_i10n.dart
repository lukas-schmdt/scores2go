import 'package:scores_2_go/l10n/score_i10n.dart';

class QsofaI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'qSOFA',
      'description': 'Quick Sequential Organ Failure Assessment — bedside '
          'screening tool for suspected sepsis outside the ICU. A score of '
          '2 or more indicates increased risk of poor outcome.',

      'group.assessment.display': 'qSOFA Criteria',
      'group.assessment.description':
          '1 point is assigned for each criterion present.',

      'resp-rate.display': 'Respiratory Rate ≥ 22/min',
      'resp-rate.description':
          'Respiratory rate of 22 breaths per minute or higher.',
      'mentation.display': 'Altered Mentation',
      'mentation.description':
          'Any alteration of mentation — Glasgow Coma Scale score below 15 '
          '(Sepsis-3 convention). The derivation model used GCS ≤ 13; the two '
          'cut-offs performed equivalently.',
      'sbp.display': 'Systolic Blood Pressure ≤ 100 mmHg',
      'sbp.description': 'Systolic blood pressure of 100 mmHg or lower.',
      // Calculation output
      'calc.incomplete': 'Please assess all three criteria.',
      'calc.interp.high':
          'Positive qSOFA (≥ 2) — in suspected infection, associated with a '
          '3- to 14-fold higher in-hospital mortality. Assess for organ '
          'dysfunction (e.g. SOFA). qSOFA does not diagnose sepsis.',
      'calc.interp.low':
          'Negative qSOFA (< 2) — does not rule out sepsis: sensitivity for '
          'mortality is only about 50 %. Do not defer investigation or '
          'treatment of suspected infection; reassess if status changes.',
    },
    'de': {
      'display': 'qSOFA',
      'description': 'Quick Sequential Organ Failure Assessment — '
          'Bedside-Screening-Instrument bei Sepsisverdacht außerhalb der '
          'Intensivstation. Ein Score von 2 oder mehr zeigt ein erhöhtes '
          'Risiko für einen ungünstigen Verlauf an.',

      'group.assessment.display': 'qSOFA-Kriterien',
      'group.assessment.description':
          'Für jedes vorliegende Kriterium wird 1 Punkt vergeben.',

      'resp-rate.display': 'Atemfrequenz ≥ 22/min',
      'resp-rate.description':
          'Atemfrequenz von 22 Atemzügen pro Minute oder höher.',
      'mentation.display': 'Veränderter mentaler Status',
      'mentation.description':
          'Jede Veränderung des mentalen Status — Glasgow Coma Scale unter '
          '15 (Sepsis-3-Konvention). Das Ableitungsmodell verwendete GCS ≤ 13; '
          'beide Grenzwerte schnitten gleichwertig ab.',
      'sbp.display': 'Systolischer Blutdruck ≤ 100 mmHg',
      'sbp.description': 'Systolischer Blutdruck von 100 mmHg oder niedriger.',
      // Calculation output
      'calc.incomplete': 'Bitte alle drei Kriterien beurteilen.',
      'calc.interp.high':
          'qSOFA positiv (≥ 2) — bei Infektionsverdacht mit einer 3- bis '
          '14-fach höheren Krankenhausmortalität assoziiert. Auf '
          'Organdysfunktion abklären (z. B. SOFA). qSOFA diagnostiziert keine '
          'Sepsis.',
      'calc.interp.low':
          'qSOFA negativ (< 2) — schließt eine Sepsis nicht aus: Die '
          'Sensitivität für Mortalität liegt nur bei etwa 50 %. Diagnostik und '
          'Therapie einer vermuteten Infektion nicht aufschieben; bei '
          'Zustandsänderung neu beurteilen.',
    },
  };
}

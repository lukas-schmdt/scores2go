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
          'Glasgow Coma Scale score below 15 (any deviation from normal alertness).',
      'sbp.display': 'Systolic Blood Pressure ≤ 100 mmHg',
      'sbp.description': 'Systolic blood pressure of 100 mmHg or lower.',
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
      'mentation.display': 'Veränderter Bewusstseinszustand',
      'mentation.description':
          'Glasgow Coma Scale unter 15 (jede Abweichung von normaler Wachheit).',
      'sbp.display': 'Systolischer Blutdruck ≤ 100 mmHg',
      'sbp.description': 'Systolischer Blutdruck von 100 mmHg oder niedriger.',
    },
  };
}

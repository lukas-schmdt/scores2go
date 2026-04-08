import 'package:scores_2_go/l10n/score_i10n.dart';

class RamsayI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'Ramsay Scale',
      'description':
          'The Ramsay Sedation Scale measures the level of sedation in '
          'ICU patients. Scores 2–3 indicate adequate sedation.',
      'group.display': 'Sedation Level',
      'group.description': 'Select the level that best describes the patient.',
      'level.display': 'Ramsay Level',
      'level.description': 'Assess the patient\'s responsiveness.',
      'level.1': 'Level 1 – Anxious, agitated or restless',
      'level.2': 'Level 2 – Cooperative, oriented and tranquil',
      'level.3': 'Level 3 – Responds to commands only',
      'level.4': 'Level 4 – Asleep; brisk response to stimulus',
      'level.5': 'Level 5 – Asleep; sluggish response to stimulus',
      'level.6': 'Level 6 – Asleep; no response to stimulus',
    },
    'de': {
      'display': 'Ramsay-Skala',
      'description':
          'Die Ramsay-Sedierungsskala erfasst den Sedierungsgrad bei '
          'Intensivpatienten. Stufen 2–3 gelten als angestrebte Sedierung.',
      'group.display': 'Sedierungsgrad',
      'group.description':
          'Wählen Sie den Grad aus, der den Patienten am besten beschreibt.',
      'level.display': 'Ramsay-Grad',
      'level.description': 'Reagibilität des Patienten beurteilen.',
      'level.1': 'Stufe 1 – Ängstlich, agitiert oder unruhig',
      'level.2': 'Stufe 2 – Kooperativ, orientiert und ruhig',
      'level.3': 'Stufe 3 – Reagiert nur auf Aufforderung',
      'level.4': 'Stufe 4 – Schlafend; prompte Reaktion auf Reiz',
      'level.5': 'Stufe 5 – Schlafend; träge Reaktion auf Reiz',
      'level.6': 'Stufe 6 – Schlafend; keine Reaktion auf Reiz',
    },
  };
}

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
      // Calculation output
      'calc.incomplete': 'Please select a sedation level.',
      'calc.secondaryLabel': 'Assessment',
      'calc.levelResult': 'Level',
      'calc.interp.1': 'Anxious, agitated or restless',
      'calc.interp.2': 'Cooperative, oriented and tranquil',
      'calc.interp.3': 'Responds to commands only',
      'calc.interp.4': 'Asleep; brisk response to glabellar tap or loud noise',
      'calc.interp.5':
          'Asleep; sluggish response to glabellar tap or loud noise',
      'calc.interp.6': 'Asleep; no response to stimulus',
      'calc.rating.1': 'Inadequate sedation – patient agitated',
      'calc.rating.2_3': 'Target sedation goal',
      'calc.rating.4_5': 'Deep sedation – reassess target',
      'calc.rating.6': 'Very deep sedation – possible overdose',
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
      // Calculation output
      'calc.incomplete': 'Bitte Sedierungsgrad auswählen.',
      'calc.secondaryLabel': 'Bewertung',
      'calc.levelResult': 'Stufe',
      'calc.interp.1': 'Ängstlich, agitiert oder unruhig',
      'calc.interp.2': 'Kooperativ, orientiert und ruhig',
      'calc.interp.3': 'Reagiert nur auf Aufforderung',
      'calc.interp.4':
          'Schlafend; prompte Reaktion auf Glabellaschlag oder lauten Stimulus',
      'calc.interp.5':
          'Schlafend; träge Reaktion auf Glabellaschlag oder lauten Stimulus',
      'calc.interp.6': 'Schlafend; keine Reaktion auf Stimulus',
      'calc.rating.1': 'Unzureichende Sedierung – Patient agitiert',
      'calc.rating.2_3': 'Angestrebtes Sedierungsziel',
      'calc.rating.4_5': 'Tiefe Sedierung – Ziel überprüfen',
      'calc.rating.6': 'Sehr tiefe Sedierung – Überdosierung möglich',
    },
  };
}

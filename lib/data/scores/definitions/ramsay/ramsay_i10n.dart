import 'package:scores_2_go/l10n/score_i10n.dart';

class RamsayI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'Ramsay Scale',
      'description':
          'The Ramsay Sedation Scale measures the level of sedation in '
          'ICU patients. Levels 2–3 are commonly used as a light-sedation '
          'target.',
      'group.display': 'Sedation Level',
      'group.description': 'Select the level that best describes the patient.',
      'level.display': 'Ramsay Level',
      'level.description': 'Assess the patient\'s responsiveness.',
      'level.1': 'Level 1 – Awake; anxious, agitated or restless',
      'level.2': 'Level 2 – Awake; cooperative, oriented and tranquil',
      'level.3': 'Level 3 – Awake; responds to commands only',
      'level.4':
          'Level 4 – Asleep; brisk response to light glabellar tap or loud '
          'auditory stimulus',
      'level.5':
          'Level 5 – Asleep; sluggish response to light glabellar tap or loud '
          'auditory stimulus',
      'level.6':
          'Level 6 – Asleep; no response to glabellar tap or loud auditory '
          'stimulus',
      // Calculation output
      'calc.incomplete': 'Please select a sedation level.',
      'calc.secondaryLabel': 'Assessment',
      'calc.levelResult': 'Level',
      'calc.interp.1': 'Awake; anxious, agitated or restless',
      'calc.interp.2': 'Awake; cooperative, oriented and tranquil',
      'calc.interp.3': 'Awake; responds to commands only',
      'calc.interp.4':
          'Asleep; brisk response to light glabellar tap or loud auditory '
          'stimulus',
      'calc.interp.5':
          'Asleep; sluggish response to light glabellar tap or loud auditory '
          'stimulus',
      'calc.interp.6':
          'Asleep; no response to glabellar tap or loud auditory stimulus',
      'calc.rating.1': 'Agitated – inadequate sedation if sedation is intended',
      'calc.rating.2_3': 'Commonly used light-sedation target – individualise',
      'calc.rating.4_5': 'Deeper sedation – reassess whether intended',
      'calc.rating.6':
          'Unresponsive – confirm this is intended; consider neurological '
          'causes',
    },
    'de': {
      'display': 'Ramsay-Skala',
      'description':
          'Die Ramsay-Sedierungsskala erfasst den Sedierungsgrad bei '
          'Intensivpatienten. Stufen 2–3 werden häufig als Ziel leichter '
          'Sedierung verwendet.',
      'group.display': 'Sedierungsgrad',
      'group.description':
          'Wählen Sie den Grad aus, der den Patienten am besten beschreibt.',
      'level.display': 'Ramsay-Grad',
      'level.description': 'Reagibilität des Patienten beurteilen.',
      'level.1': 'Stufe 1 – Wach; ängstlich, agitiert oder unruhig',
      'level.2': 'Stufe 2 – Wach; kooperativ, orientiert und ruhig',
      'level.3': 'Stufe 3 – Wach; reagiert nur auf Aufforderung',
      'level.4':
          'Stufe 4 – Schlafend; prompte Reaktion auf leichtes Klopfen auf die '
          'Glabella oder lauten akustischen Reiz',
      'level.5':
          'Stufe 5 – Schlafend; träge Reaktion auf leichtes Klopfen auf die '
          'Glabella oder lauten akustischen Reiz',
      'level.6':
          'Stufe 6 – Schlafend; keine Reaktion auf Klopfen auf die Glabella '
          'oder lauten akustischen Reiz',
      // Calculation output
      'calc.incomplete': 'Bitte Sedierungsgrad auswählen.',
      'calc.secondaryLabel': 'Bewertung',
      'calc.levelResult': 'Stufe',
      'calc.interp.1': 'Wach; ängstlich, agitiert oder unruhig',
      'calc.interp.2': 'Wach; kooperativ, orientiert und ruhig',
      'calc.interp.3': 'Wach; reagiert nur auf Aufforderung',
      'calc.interp.4':
          'Schlafend; prompte Reaktion auf leichtes Klopfen auf die Glabella '
          'oder lauten akustischen Reiz',
      'calc.interp.5':
          'Schlafend; träge Reaktion auf leichtes Klopfen auf die Glabella '
          'oder lauten akustischen Reiz',
      'calc.interp.6':
          'Schlafend; keine Reaktion auf Klopfen auf die Glabella oder lauten '
          'akustischen Reiz',
      'calc.rating.1':
          'Agitiert – unzureichende Sedierung, falls Sedierung beabsichtigt',
      'calc.rating.2_3':
          'Häufig verwendetes Ziel leichter Sedierung – individuell festlegen',
      'calc.rating.4_5': 'Tiefere Sedierung – prüfen, ob beabsichtigt',
      'calc.rating.6':
          'Nicht reagibel – prüfen, ob beabsichtigt; neurologische Ursachen '
          'erwägen',
    },
  };
}

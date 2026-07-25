import 'package:scores_2_go/l10n/score_i10n.dart';

class RassI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'RASS',
      'description':
          'The Richmond Agitation-Sedation Scale assesses the level of sedation '
          'and agitation in ICU patients.',
      'group.display': 'Agitation / Sedation',
      'group.description': 'Select the level that best describes the patient.',
      'level.display': 'RASS Level',
      'level.description':
          'Observe the patient for 30 seconds before scoring.',
      'level.plus4': '+4 · Combative',
      'level.plus3': '+3 · Very agitated',
      'level.plus2': '+2 · Agitated',
      'level.plus1': '+1 · Restless',
      'level.zero': '0 · Alert and calm',
      'level.minus1': '-1 · Drowsy',
      'level.minus2': '-2 · Light sedation',
      'level.minus3': '-3 · Moderate sedation',
      'level.minus4': '-4 · Deep sedation',
      'level.minus5': '-5 · Unarousable',
      // Calculation output
      'calc.incomplete': 'Please select a RASS level.',
      'calc.interp.plus4': 'Combative – overtly combative, violent, immediate danger to staff',
      'calc.interp.plus3': 'Very agitated – pulls or removes tubes/catheters, aggressive',
      'calc.interp.plus2': 'Agitated – frequent non-purposeful movement',
      'calc.interp.plus1': 'Restless – anxious but movements not aggressive',
      'calc.interp.zero': 'Alert and calm',
      'calc.interp.minus1':
          'Drowsy – not fully alert, but sustained awakening to voice > 10 s',
      'calc.interp.minus2':
          'Light sedation – briefly awakens to voice < 10 s',
      'calc.interp.minus3':
          'Moderate sedation – movement or eye opening to voice, no eye contact',
      'calc.interp.minus4':
          'Deep sedation – no response to voice, response to physical stimulation',
      'calc.interp.minus5':
          'Unarousable – no response to voice or physical stimulation',
    },
    'de': {
      'display': 'RASS',
      'description':
          'Die Richmond Agitation-Sedation Scale bewertet das Ausmaß von '
          'Sedierung und Agitation bei Intensivpatienten.',
      'group.display': 'Agitation / Sedierung',
      'group.description':
          'Wählen Sie den Grad aus, der den Patienten am besten beschreibt.',
      'level.display': 'RASS-Grad',
      'level.description':
          'Patient 30 Sekunden beobachten, dann beurteilen.',
      'level.plus4': '+4 · Streitlustig / gefährlich agitiert',
      'level.plus3': '+3 · Stark agitiert',
      'level.plus2': '+2 · Agitiert',
      'level.plus1': '+1 · Unruhig',
      'level.zero': '0 · Wach und kooperativ',
      'level.minus1': '-1 · Schläfrig',
      'level.minus2': '-2 · Leichte Sedierung',
      'level.minus3': '-3 · Mäßige Sedierung',
      'level.minus4': '-4 · Tiefe Sedierung',
      'level.minus5': '-5 · Nicht erweckbar',
      // Calculation output
      'calc.incomplete': 'Bitte RASS-Grad auswählen.',
      'calc.interp.plus4': 'Streitlustig – kämpferisch, gefährlich',
      'calc.interp.plus3':
          'Stark agitiert – zieht Zugänge, kämpft gegen Beatmung',
      'calc.interp.plus2': 'Agitiert – häufige, ungezielte Bewegungen',
      'calc.interp.plus1':
          'Unruhig – ängstlich, aber Bewegungen nicht aggressiv',
      'calc.interp.zero': 'Wach und kooperativ',
      'calc.interp.minus1':
          'Schläfrig – nicht ganz wach, aber auf Stimme wach > 10 s',
      'calc.interp.minus2':
          'Leichte Sedierung – kurz wach auf Ansprache < 10 s',
      'calc.interp.minus3':
          'Mäßige Sedierung – Bewegung auf Ansprache, kein Augenkontakt',
      'calc.interp.minus4':
          'Tiefe Sedierung – keine Reaktion auf Ansprache, Reaktion auf Schmerz',
      'calc.interp.minus5':
          'Nicht erweckbar – keine Reaktion auf Stimme oder Schmerzreiz',
    },
  };
}

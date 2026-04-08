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
    },
  };
}

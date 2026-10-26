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
          '1. Observe the patient. 2. If not alert, call the patient by name '
          'and ask them to open their eyes and look at you. 3. If there is no '
          'response to voice, shake the shoulder and/or rub the sternum.',
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
      'calc.secondaryLabel': 'Assessment',
      'calc.interp.plus4':
          'Combative – overtly combative or violent, immediate danger to staff',
      'calc.interp.plus3':
          'Very agitated – pulls on or removes tubes/catheters, or aggressive '
          'towards staff',
      'calc.interp.plus2':
          'Agitated – frequent non-purposeful movement or patient–ventilator '
          'dyssynchrony',
      'calc.interp.plus1':
          'Restless – anxious or apprehensive, but movements not aggressive or '
          'vigorous',
      'calc.interp.zero': 'Alert and calm',
      'calc.interp.minus1':
          'Drowsy – not fully alert, but sustained awakening (eye opening / '
          'eye contact) to voice > 10 s',
      'calc.interp.minus2':
          'Light sedation – briefly awakens with eye contact to voice < 10 s',
      'calc.interp.minus3':
          'Moderate sedation – movement or eye opening to voice, but no eye '
          'contact',
      'calc.interp.minus4':
          'Deep sedation – no response to voice, but movement or eye opening '
          'to physical stimulation',
      'calc.interp.minus5':
          'Unarousable – no response to voice or physical stimulation',
      'calc.rating.agitated':
          'Agitation – consider pain (BPS/CPOT) and hyperactive delirium',
      'calc.rating.light':
          'Alert to lightly sedated – RASS -2 to 0 is used as light sedation in '
          'studies; light sedation is recommended for most ventilated adults',
      'calc.rating.moderate':
          'Counted as deep sedation in outcome studies – reassess whether '
          'intended',
      'calc.rating.coma':
          'Coma range – reassess whether deep sedation is intended',
      'calc.deliriumScreeningLimited':
          'Delirium screening is limited at RASS -4/-5 (e.g. ICDSC items 1–4 '
          'cannot be completed).',
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
          '1. Patient beobachten. 2. Falls nicht wach: mit Namen ansprechen und '
          'auffordern, die Augen zu öffnen und Sie anzusehen. 3. Falls keine '
          'Reaktion auf Ansprache: Schulter rütteln und/oder Sternum reiben.',
      'level.plus4': '+4 · Aggressiv',
      'level.plus3': '+3 · Stark agitiert',
      'level.plus2': '+2 · Agitiert',
      'level.plus1': '+1 · Unruhig',
      'level.zero': '0 · Wach und ruhig',
      'level.minus1': '-1 · Schläfrig',
      'level.minus2': '-2 · Leichte Sedierung',
      'level.minus3': '-3 · Mäßige Sedierung',
      'level.minus4': '-4 · Tiefe Sedierung',
      'level.minus5': '-5 · Nicht erweckbar',
      // Calculation output
      'calc.incomplete': 'Bitte RASS-Grad auswählen.',
      'calc.secondaryLabel': 'Bewertung',
      'calc.interp.plus4':
          'Aggressiv – offen kämpferisch oder gewalttätig, unmittelbare Gefahr '
          'für das Personal',
      'calc.interp.plus3':
          'Stark agitiert – zieht an oder entfernt Tubus/Katheter oder '
          'aggressiv gegenüber dem Personal',
      'calc.interp.plus2':
          'Agitiert – häufige ungezielte Bewegungen oder Patient-Beatmungsgerät-'
          'Asynchronie',
      'calc.interp.plus1':
          'Unruhig – ängstlich oder besorgt, aber Bewegungen nicht aggressiv '
          'oder heftig',
      'calc.interp.zero': 'Wach und ruhig',
      'calc.interp.minus1':
          'Schläfrig – nicht ganz wach, aber anhaltend wach auf Ansprache '
          '(Augenöffnen / Blickkontakt > 10 s)',
      'calc.interp.minus2':
          'Leichte Sedierung – erwacht kurz mit Blickkontakt auf Ansprache '
          '(< 10 s)',
      'calc.interp.minus3':
          'Mäßige Sedierung – Bewegung oder Augenöffnen auf Ansprache, aber '
          'kein Blickkontakt',
      'calc.interp.minus4':
          'Tiefe Sedierung – keine Reaktion auf Ansprache, aber Bewegung oder '
          'Augenöffnen auf körperliche Stimulation',
      'calc.interp.minus5':
          'Nicht erweckbar – keine Reaktion auf Ansprache oder körperliche '
          'Stimulation',
      'calc.rating.agitated':
          'Agitation – an Schmerz (BPS/CPOT) und hyperaktives Delir denken',
      'calc.rating.light':
          'Wach bis leicht sediert – RASS -2 bis 0 wird in Studien als leichte '
          'Sedierung verwendet; leichte Sedierung wird für die meisten '
          'beatmeten Erwachsenen empfohlen',
      'calc.rating.moderate':
          'In Outcome-Studien als tiefe Sedierung gewertet – prüfen, ob '
          'beabsichtigt',
      'calc.rating.coma':
          'Komabereich – prüfen, ob eine tiefe Sedierung beabsichtigt ist',
      'calc.deliriumScreeningLimited':
          'Delir-Screening bei RASS -4/-5 eingeschränkt (z. B. ICDSC-Items 1–4 '
          'nicht beurteilbar).',
    },
  };
}

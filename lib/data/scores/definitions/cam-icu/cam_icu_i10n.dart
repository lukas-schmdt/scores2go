import 'package:scores_2_go/l10n/score_i10n.dart';

class CamIcuI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'CAM-ICU',
      'description': 'Confusion Assessment Method for the ICU — algorithm-based delirium assessment for non-verbal ICU patients.',
      'group.display': 'CAM-ICU Assessment',
      'group.description':
          'Complete features 1 and 2. Features 3 and 4 appear when both are positive.',
      'feature1.display': 'Feature 1 – Acute onset or fluctuating course',
      'feature1.description':
          'Is there evidence of an acute change in mental status from baseline, or did the patient\'s mental status fluctuate during the past 24 hours (e.g. changes in RASS, GCS, or prior delirium assessments)?',
      'feature2.display': 'Feature 2 – Inattention',
      'feature2.description':
          'Did the patient have difficulty focusing attention? Score < 8 on the SAVE letter test (squeeze on "A") or pictures attention test.',
      'feature3.display': 'Feature 3 – Altered level of consciousness',
      'feature3.description':
          'Is the patient\'s current RASS score anything other than 0 (Alert and calm)? Any level of sedation or agitation counts as altered consciousness.',
      'feature4.display': 'Feature 4 – Disorganized thinking',
      'feature4.description':
          'Did the patient have disorganized or incoherent thinking? Assess via 4 yes/no questions and a simple command (e.g. "Hold up this many fingers" / "Now do the same with the other hand").',
      // Calculation output
      'calc.incomplete12': 'Please assess features 1 and 2.',
      'calc.incomplete34':
          'Features 1 and 2 are positive. Please assess features 3 and 4.',
      'calc.negative': 'Negative',
      'calc.positive': 'Positive',
      'calc.noDeliriumDetected': 'No delirium detected.',
      'calc.deliriumPresent':
          'Delirium present — initiate delirium management protocol.',
    },
    'de': {
      'display': 'CAM-ICU',
      'description': 'Confusion Assessment Method für die ICU — algorithmusbasierte Delir-Erfassung bei nicht-verbalen Intensivpatienten.',
      'group.display': 'CAM-ICU Beurteilung',
      'group.description':
          'Merkmale 1 und 2 beurteilen. Merkmale 3 und 4 erscheinen, wenn beide positiv sind.',
      'feature1.display': 'Merkmal 1 – Akuter Beginn oder fluktuierender Verlauf',
      'feature1.description':
          'Gibt es Hinweise auf eine akute Änderung des Bewusstseinszustands gegenüber dem Ausgangswert oder fluktuiert der Zustand des Patienten in den letzten 24 Stunden (z. B. Änderungen im RASS, GCS oder früheren Delir-Beurteilungen)?',
      'feature2.display': 'Merkmal 2 – Aufmerksamkeitsstörung',
      'feature2.description':
          'Hat der Patient Schwierigkeiten, die Aufmerksamkeit zu fokussieren? Weniger als 8/10 im SAVE-Buchstabentest (Drücken bei „A") oder im Bildertest.',
      'feature3.display': 'Merkmal 3 – Veränderte Bewusstseinslage',
      'feature3.description':
          'Ist der aktuelle RASS-Wert des Patienten ungleich 0 (wach und kooperativ)? Jede Form von Sedierung oder Agitation gilt als veränderte Bewusstseinslage.',
      'feature4.display': 'Merkmal 4 – Desorganisiertes Denken',
      'feature4.description':
          'Zeigt der Patient desorganisiertes oder inkohärentes Denken? Beurteilung anhand von 4 Ja/Nein-Fragen und einem einfachen Befehl (z. B. „Heben Sie so viele Finger" / „Jetzt mit der anderen Hand").',
      // Calculation output
      'calc.incomplete12': 'Bitte Merkmale 1 und 2 beurteilen.',
      'calc.incomplete34':
          'Merkmale 1 und 2 sind positiv. Bitte Merkmale 3 und 4 beurteilen.',
      'calc.negative': 'Negativ',
      'calc.positive': 'Positiv',
      'calc.noDeliriumDetected': 'Kein Delir festgestellt.',
      'calc.deliriumPresent':
          'Delir vorhanden — Delir-Management-Protokoll einleiten.',
    },
  };
}

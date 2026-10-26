import 'package:scores_2_go/l10n/score_i10n.dart';

class NudescI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'Nu-DESC',
      'description':
          'Nursing Delirium Screening Scale — a brief 5-item nurse-rated tool for delirium screening.',
      'group.display': 'Assessment',
      'group.description':
          'Rate each item based on observations over the current shift (e.g. 8–12 h).',
      'disorientation.display': 'Disorientation',
      'disorientation.description':
          'Verbal or behavioural manifestation of not being oriented to time or place, or misperceiving persons in the surroundings.',
      'inappropriate-behavior.display': 'Inappropriate behavior',
      'inappropriate-behavior.description':
          'Behaviour inappropriate to the place and/or person, e.g. pulling at tubes or dressings, trying to get out of bed when contraindicated.',
      'inappropriate-communication.display': 'Inappropriate communication',
      'inappropriate-communication.description':
          'Communication inappropriate to the place and/or person, e.g. incoherence, lack of communication, nonsensical or unintelligible speech.',
      'illusions.display': 'Illusions / hallucinations',
      'illusions.description':
          'Seeing or hearing things that are not there; distortion of visual objects.',
      'psychomotor-retardation.display': 'Psychomotor retardation',
      'psychomotor-retardation.description':
          'Delayed responsiveness, few or no spontaneous actions or words, e.g. delayed reaction when prodded, or patient cannot be aroused.',
      'opt.absent': 'Absent',
      'opt.mild': 'Mild or occasional',
      'opt.present': 'Marked, frequent or intense',
      // Calculation output
      'calc.incomplete': 'Please rate all 5 items to obtain a score.',
      'calc.interp.0':
          'Negative screen (below the standard cutoff of ≥ 2). A negative screen does not exclude delirium — sensitivity is limited, especially for hypoactive delirium. Reassess each shift.',
      'calc.interp.1':
          'Negative at the standard cutoff (≥ 2). A total of 1 is positive at the more sensitive cutoff of ≥ 1 validated in the recovery room/postoperative setting — consider closer observation and confirm clinically if suspicion exists.',
      'calc.interp.positive':
          'Positive screen — delirium suspected. Confirm with a diagnostic assessment (e.g. CAM / CAM-ICU or DSM-5 criteria) and look for causes.',
    },
    'de': {
      'display': 'Nu-DESC',
      'description':
          'Nursing Delirium Screening Scale — ein kurzes 5-Punkte-Instrument zur pflegerischen Delir-Erfassung.',
      'group.display': 'Beurteilung',
      'group.description':
          'Jedes Item anhand der Beobachtungen der aktuellen Schicht (z. B. 8–12 h) bewerten.',
      'disorientation.display': 'Desorientierung',
      'disorientation.description':
          'Manifestierung einer Desorientierung zu Zeit oder Ort durch Worte oder Verhalten oder Nicht-Erkennen der umgebenden Personen.',
      'inappropriate-behavior.display': 'Unangemessenes Verhalten',
      'inappropriate-behavior.description':
          'Unangemessenes Verhalten zu Ort und/oder Person, z. B. Ziehen an Kathetern oder Verbänden, Versuch, aus dem Bett zu steigen, obwohl kontraindiziert.',
      'inappropriate-communication.display': 'Unangemessene Kommunikation',
      'inappropriate-communication.description':
          'Unangemessene Kommunikation zu Ort und/oder Person, z. B. zusammenhanglose oder gar keine Kommunikation, unsinnige oder unverständliche sprachliche Äußerungen.',
      'illusions.display': 'Illusionen / Halluzinationen',
      'illusions.description':
          'Sehen oder Hören nicht vorhandener Dinge, Verzerrung optischer oder akustischer Eindrücke.',
      'psychomotor-retardation.display': 'Psychomotorische Retardierung',
      'psychomotor-retardation.description':
          'Verlangsamte Ansprechbarkeit, wenige oder keine spontane Aktivität/Äußerung, z. B. verzögerte Reaktion auf Ansprache, oder Patient nicht erweckbar.',
      'opt.absent': 'Nicht vorhanden',
      'opt.mild': 'Leicht oder gelegentlich',
      'opt.present': 'Ausgeprägt, häufig oder intensiv',
      // Calculation output
      'calc.incomplete': 'Bitte alle 5 Items bewerten, um einen Score zu erhalten.',
      'calc.interp.0':
          'Negatives Screening (unterhalb des Standard-Cutoffs von ≥ 2). Ein negatives Screening schließt ein Delir nicht aus — die Sensitivität ist begrenzt, insbesondere beim hypoaktiven Delir. In jeder Schicht erneut beurteilen.',
      'calc.interp.1':
          'Negatives Screening beim Standard-Cutoff (≥ 2). Ein Gesamtwert von 1 ist beim sensitiveren Cutoff von ≥ 1 (validiert im Aufwachraum/postoperativ) positiv — bei klinischem Verdacht engmaschiger beobachten und klinisch abklären.',
      'calc.interp.positive':
          'Positives Screening – Delir-Verdacht; Bestätigung durch diagnostische Beurteilung (z. B. CAM/CAM-ICU, DSM-5) und Ursachensuche.',
    },
  };
}

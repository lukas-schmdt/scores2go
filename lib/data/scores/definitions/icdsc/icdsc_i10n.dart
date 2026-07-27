import 'package:scores_2_go/l10n/score_i10n.dart';

class IcdscI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'ICDSC',
      'description':
          'Intensive Care Delirium Screening Checklist — 8-item nurse-rated checklist scored once per shift to detect and grade ICU delirium.',
      'group.display': 'ICDSC Assessment',
      'group.description':
          'Rate item 1 first at the bedside. If the patient is stuporous or comatose (A/B), the assessment stops there. Otherwise rate items 2–4 from a focused bedside evaluation and items 5–8 from observations across the whole shift; items 7 and 8 specifically refer to the preceding 24 hours. Complete once per 8-hour nursing shift (or once per 24 hours).',
      // Item 1 — level of consciousness
      'loc.display': '1. Altered level of consciousness',
      'loc.description':
          'Rate the patient\'s level of consciousness using the original ICDSC A–E wording. Approximate RASS equivalence: A/B ≈ RASS −4/−5; C ≈ RASS −1 to −3; D ≈ RASS 0; E ≈ RASS +1 to +4. A or B halts the assessment — items 2–8 cannot be rated.',
      'loc.opt.a':
          'A — No response to stimulation (coma) — not assessable',
      'loc.opt.b':
          'B — Response only to intense/repeated stimulation (stupor) — not assessable',
      'loc.opt.c':
          'C — Response to mild-to-moderate stimulation (drowsy / sopor)',
      'loc.opt.d': 'D — Normal wakefulness',
      'loc.opt.e':
          'E — Exaggerated response to normal stimulation (agitation)',
      // Item 2
      'inattention.display': '2. Inattention',
      'inattention.description':
          'Difficulty following instructions or conversation; easily distracted by external stimuli; difficulty shifting focus. Any of these present scores 1 point.',
      // Item 3
      'disorientation.display': '3. Disorientation',
      'disorientation.description':
          'Any obvious mistake in time, place, or person.',
      // Item 4
      'hallucinations.display':
          '4. Hallucinations, delusions or psychosis',
      'hallucinations.description':
          'Unequivocal hallucinations or behaviour likely due to hallucinations (e.g. trying to catch a non-existent object); delusions; or gross impairment in reality testing.',
      // Item 5
      'psychomotor.display':
          '5. Psychomotor agitation or retardation',
      'psychomotor.description':
          'Hyperactivity requiring additional sedatives or restraints to control potential danger (e.g. pulling out IV lines, striking staff), OR hypoactivity/clinically noticeable psychomotor slowing.',
      // Item 6
      'speech-mood.display': '6. Inappropriate speech or mood',
      'speech-mood.description':
          'Disorganised or incoherent speech; inappropriate display of emotion related to events or situation (e.g. apathetic or overly demanding); or inappropriate comments.',
      // Item 7
      'sleep-wake.display': '7. Sleep/wake cycle disturbance',
      'sleep-wake.description':
          'Sleep less than 4 hours at night, or frequent waking at night (not caused by staff or a noisy environment), or sleeping for most of the day.',
      // Item 8
      'fluctuation.display': '8. Symptom fluctuation',
      'fluctuation.description':
          'Fluctuation of any of the above items (1–7) over the preceding 24 hours (e.g. from one shift to the next).',
      // Calculation output
      'calc.incompleteLoc':
          'Please rate item 1 (level of consciousness) to begin the assessment.',
      'calc.incompleteItems':
          'Please rate all remaining items (2–8) to obtain a total score.',
      'calc.notAssessableResult': 'Not assessable',
      'calc.notAssessableInterpretation':
          'Level of consciousness A or B (coma/stupor) — the delirium assessment cannot be completed in stuporous or comatose patients. Reassess once the patient responds at least to mild-to-moderate stimulation.',
      'calc.noDelirium': 'No delirium',
      'calc.noDeliriumInterpretation':
          'No delirium (score 0) — no signs of delirium at this assessment.',
      'calc.subsyndromal': 'Subsyndromal delirium',
      'calc.subsyndromalInterpretation':
          'Subsyndromal delirium (score 1–3) — an intermediate state between no delirium and delirium, associated with worse outcomes than a score of 0 (higher ICU mortality and longer length of stay) though not diagnostic of delirium. Increased monitoring is recommended.',
      'calc.delirium': 'Delirium',
      'calc.deliriumInterpretation':
          'Delirium (score ≥ 4) — delirium is present. The ICDSC does not grade severity above this threshold; it indicates presence only.',
    },
    'de': {
      'display': 'ICDSC',
      'description':
          'Intensive Care Delirium Screening Checklist — 8-Punkte-Checkliste zur pflegerischen Delirbeurteilung, einmal pro Schicht erhoben.',
      'group.display': 'ICDSC Beurteilung',
      'group.description':
          'Item 1 zuerst am Patientenbett beurteilen. Ist der Patient stuporös oder komatös (A/B), endet die Beurteilung dort. Andernfalls Items 2–4 anhand einer gezielten Bettbeurteilung und Items 5–8 anhand der Beobachtungen der gesamten Schicht bewerten; Items 7 und 8 beziehen sich ausdrücklich auf die vorangegangenen 24 Stunden. Einmal pro 8-Stunden-Schicht (bzw. einmal pro 24 Stunden) durchführen.',
      // Item 1 — Bewusstseinslage
      'loc.display': '1. Veränderte Bewusstseinslage',
      'loc.description':
          'Bewusstseinslage nach der originalen ICDSC A–E-Einteilung bewerten. Näherungsweise RASS-Entsprechung: A/B ≈ RASS −4/−5; C ≈ RASS −1 bis −3; D ≈ RASS 0; E ≈ RASS +1 bis +4. A oder B beendet die Beurteilung — Items 2–8 können dann nicht bewertet werden.',
      'loc.opt.a':
          'A — Keine Reaktion auf Stimulation (Koma) — nicht beurteilbar',
      'loc.opt.b':
          'B — Reaktion nur auf intensive/wiederholte Stimulation (Stupor) — nicht beurteilbar',
      'loc.opt.c':
          'C — Reaktion auf leichte bis mäßige Stimulation (schläfrig / soporös)',
      'loc.opt.d': 'D — Normale Wachheit',
      'loc.opt.e':
          'E — Überschießende Reaktion auf normale Stimulation (Agitation)',
      // Item 2
      'inattention.display': '2. Aufmerksamkeitsstörung',
      'inattention.description':
          'Schwierigkeiten, Anweisungen oder einem Gespräch zu folgen; leichte Ablenkbarkeit durch äußere Reize; Schwierigkeiten, den Fokus zu wechseln. Trifft eines davon zu, wird 1 Punkt vergeben.',
      // Item 3
      'disorientation.display': '3. Desorientierung',
      'disorientation.description':
          'Jeder offensichtliche Fehler bezüglich Zeit, Ort oder Person.',
      // Item 4
      'hallucinations.display': '4. Halluzinationen, Wahnvorstellungen oder Psychose',
      'hallucinations.description':
          'Eindeutige Halluzinationen oder Verhalten, das wahrscheinlich auf Halluzinationen zurückzuführen ist (z. B. Greifen nach einem nicht vorhandenen Gegenstand); Wahnvorstellungen; oder ausgeprägte Störung der Realitätswahrnehmung.',
      // Item 5
      'psychomotor.display': '5. Psychomotorische Unruhe oder Verlangsamung',
      'psychomotor.description':
          'Hyperaktivität, die zusätzliche Sedativa oder Fixierung erfordert, um eine mögliche Gefährdung zu kontrollieren (z. B. Herausziehen von Zugängen, Schlagen nach Personal), ODER Hypoaktivität/klinisch auffällige psychomotorische Verlangsamung.',
      // Item 6
      'speech-mood.display': '6. Unangemessene Sprache oder Stimmung',
      'speech-mood.description':
          'Desorganisierte oder inkohärente Sprache; unangemessene emotionale Reaktion auf Ereignisse oder Situation (z. B. apathisch oder übermäßig fordernd); oder unangemessene Äußerungen.',
      // Item 7
      'sleep-wake.display': '7. Schlaf-Wach-Rhythmus-Störung',
      'sleep-wake.description':
          'Weniger als 4 Stunden Schlaf nachts, oder häufiges nächtliches Erwachen (nicht durch Personal oder Lärm verursacht), oder Schlafen über den größten Teil des Tages.',
      // Item 8
      'fluctuation.display': '8. Symptomfluktuation',
      'fluctuation.description':
          'Fluktuation eines der obigen Items (1–7) innerhalb der vorangegangenen 24 Stunden (z. B. von einer Schicht zur nächsten).',
      // Calculation output
      'calc.incompleteLoc':
          'Bitte Item 1 (Bewusstseinslage) beurteilen, um die Beurteilung zu beginnen.',
      'calc.incompleteItems':
          'Bitte alle verbleibenden Items (2–8) bewerten, um einen Gesamtscore zu erhalten.',
      'calc.notAssessableResult': 'Nicht beurteilbar',
      'calc.notAssessableInterpretation':
          'Bewusstseinslage A oder B (Koma/Stupor) — die Delirbeurteilung kann bei stuporösen oder komatösen Patienten nicht abgeschlossen werden. Neubeurteilung, sobald der Patient mindestens auf leichte bis mäßige Stimulation reagiert.',
      'calc.noDelirium': 'Kein Delir',
      'calc.noDeliriumInterpretation':
          'Kein Delir (Score 0) — keine Hinweise auf ein Delir bei dieser Beurteilung.',
      'calc.subsyndromal': 'Subsyndromales Delir',
      'calc.subsyndromalInterpretation':
          'Subsyndromales Delir (Score 1–3) — ein intermediärer Zustand zwischen keinem Delir und einem Delir, assoziiert mit schlechteren Outcomes als bei Score 0 (höhere ICU-Mortalität und längerer Aufenthalt), jedoch nicht diagnostisch für ein Delir. Engmaschigere Überwachung wird empfohlen.',
      'calc.delirium': 'Delir',
      'calc.deliriumInterpretation':
          'Delir (Score ≥ 4) — ein Delir liegt vor. Der ICDSC graduiert den Schweregrad oberhalb dieses Grenzwerts nicht; er zeigt lediglich das Vorliegen an.',
    },
  };
}

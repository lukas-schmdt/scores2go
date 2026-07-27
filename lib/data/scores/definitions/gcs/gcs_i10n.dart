import 'package:scores_2_go/l10n/score_i10n.dart';

class GcsI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'GCS',
      'description': 'Glasgow Coma Scale — assesses level of consciousness '
          'based on eye, verbal, and motor responses. Total 3–15.',

      // Eyes group
      'eyes.group.display': 'Eye Opening (E)',
      'eyes.group.description': 'Best eye-opening response observed.',
      'eyes.display': 'Eye Opening',
      'eyes.description': 'Score 4 = spontaneous, 1 = no response. '
          '"To pressure" is graded finger-nail-bed pressure, not a sternal '
          'rub (avoided as it causes bruising).',
      'eyes.4': 'E4 · Spontaneous',
      'eyes.3': 'E3 · To sound (to speech)',
      'eyes.2': 'E2 · To pressure (to pain)',
      'eyes.1': 'E1 · None',
      'eyes.nt': 'ENT · Not testable',

      // Verbal group
      'verbal.group.display': 'Verbal Response (V)',
      'verbal.group.description': 'Best verbal response observed.',
      'verbal.display': 'Verbal Response',
      'verbal.description': 'Score 5 = orientated, 1 = no response.',
      'verbal.5': 'V5 · Orientated',
      'verbal.4': 'V4 · Confused',
      'verbal.3': 'V3 · Words (inappropriate words)',
      'verbal.2': 'V2 · Sounds (incomprehensible sounds)',
      'verbal.1': 'V1 · None',
      'verbal.nt': 'VNT · Not testable',

      // Motor group
      'motor.group.display': 'Motor Response (M)',
      'motor.group.description': 'Best motor response observed.',
      'motor.display': 'Motor Response',
      'motor.description': 'Score 6 = obeys commands, 1 = no response. '
          'Use graded pressure (finger-nail bed, trapezius pinch, or '
          'supraorbital notch) — not a sternal rub.',
      'motor.6': 'M6 · Obeys commands',
      'motor.5': 'M5 · Localising to pressure',
      'motor.4': 'M4 · Normal flexion (withdraws)',
      'motor.3': 'M3 · Abnormal flexion (decorticate)',
      'motor.2': 'M2 · Extension (decerebrate)',
      'motor.1': 'M1 · None',
      'motor.nt': 'MNT · Not testable',
      // Calculation output
      'calc.incomplete': 'Select a response in each subscale.',
      'calc.partialLabel': 'GCS (partial)',
      'calc.completeAllThree': 'Complete all three subscales for full result.',
      'calc.evmLabel': 'EVM',
      'calc.interp.mild': 'Mild — GCS 13–15',
      'calc.interp.moderate': 'Moderate — GCS 9–12',
      'calc.interp.severe': 'Severe — GCS 3–8',
      'calc.component.eyes': 'Eye-opening',
      'calc.component.verbal': 'Verbal',
      'calc.component.motor': 'Motor',
      'calc.component.and': 'and',
      'calc.ntTotalSingle':
          '{component} component not testable — total score not reported. '
          'Document the individual components ({evm}).',
      'calc.ntTotalMultiple':
          '{components} components not testable — total score not '
          'reported. Document the individual components ({evm}).',
      'calc.ntNoteLabel': 'Note',
      'calc.ntNoteValue':
          'Total not reported, per the official Glasgow structured '
          'approach (glasgowcomascale.org)',
    },
    'de': {
      'display': 'GCS',
      'description': 'Glasgow Coma Scale — bewertet das Bewusstsein anhand '
          'von Augen-, Verbal- und Motorreaktion. Gesamtpunktzahl 3–15.',

      // Eyes group
      'eyes.group.display': 'Augenöffnung (E)',
      'eyes.group.description': 'Beste beobachtete Augenöffnungsreaktion.',
      'eyes.display': 'Augenöffnung',
      'eyes.description': '4 = spontan, 1 = keine Reaktion. "Auf Druckreiz" '
          'meint einen gestuften Nagelbettdruck, keinen Sternumreiben '
          '(wird wegen Hämatombildung vermieden).',
      'eyes.4': 'E4 · Spontan',
      'eyes.3': 'E3 · Auf Ansprache',
      'eyes.2': 'E2 · Auf Druckreiz (Schmerzreiz)',
      'eyes.1': 'E1 · Keine',
      'eyes.nt': 'ENT · Nicht beurteilbar',

      // Verbal group
      'verbal.group.display': 'Verbale Reaktion (V)',
      'verbal.group.description': 'Beste beobachtete verbale Reaktion.',
      'verbal.display': 'Verbale Reaktion',
      'verbal.description': '5 = orientiert, 1 = keine Reaktion.',
      'verbal.5': 'V5 · Orientiert',
      'verbal.4': 'V4 · Verwirrt',
      'verbal.3': 'V3 · Worte (inadäquate Worte)',
      'verbal.2': 'V2 · Laute (unverständliche Laute)',
      'verbal.1': 'V1 · Keine',
      'verbal.nt': 'VNT · Nicht beurteilbar',

      // Motor group
      'motor.group.display': 'Motorische Reaktion (M)',
      'motor.group.description': 'Beste beobachtete motorische Reaktion.',
      'motor.display': 'Motorische Reaktion',
      'motor.description': '6 = befolgt Aufforderungen, 1 = keine Reaktion. '
          'Gestufter Druckreiz (Nagelbett, Trapeziuskneifen oder '
          'supraorbitaler Druck) — kein Sternumreiben.',
      'motor.6': 'M6 · Befolgt Aufforderungen',
      'motor.5': 'M5 · Gezielte Abwehr auf Druckreiz',
      'motor.4': 'M4 · Normale Beugung (ungezielte Schmerzabwehr)',
      'motor.3': 'M3 · Beugesynergien (Dekortikation)',
      'motor.2': 'M2 · Strecksynergien (Dezerebration)',
      'motor.1': 'M1 · Keine',
      'motor.nt': 'MNT · Nicht beurteilbar',
      // Calculation output
      'calc.incomplete': 'Bitte in jeder Subskala eine Antwort auswählen.',
      'calc.partialLabel': 'GCS (unvollständig)',
      'calc.completeAllThree':
          'Alle drei Subskalen für das vollständige Ergebnis ausfüllen.',
      'calc.evmLabel': 'EVM',
      'calc.interp.mild': 'Leicht — GCS 13–15',
      'calc.interp.moderate': 'Moderat — GCS 9–12',
      'calc.interp.severe': 'Schwer — GCS 3–8',
      'calc.component.eyes': 'Augenöffnung',
      'calc.component.verbal': 'Verbale Reaktion',
      'calc.component.motor': 'Motorische Reaktion',
      'calc.component.and': 'und',
      'calc.ntTotalSingle':
          'Komponente „{component}“ nicht beurteilbar — Gesamtscore wird '
          'nicht angegeben. Einzelne Komponenten dokumentieren ({evm}).',
      'calc.ntTotalMultiple':
          'Komponenten „{components}“ nicht beurteilbar — Gesamtscore '
          'wird nicht angegeben. Einzelne Komponenten dokumentieren '
          '({evm}).',
      'calc.ntNoteLabel': 'Hinweis',
      'calc.ntNoteValue':
          'Gesamtscore laut offiziellem strukturiertem GCS-Ansatz '
          '(glasgowcomascale.org) nicht angegeben',
    },
  };
}

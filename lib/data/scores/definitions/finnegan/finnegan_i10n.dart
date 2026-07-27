import 'package:scores_2_go/l10n/score_i10n.dart';

class FinneganI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'Finnegan NAS',
      'description':
          'Finnegan Neonatal Abstinence Score — assesses withdrawal severity '
          'in newborns exposed to opioids in utero (21 items, max 46). '
          'Pharmacotherapy is typically considered after three consecutive '
          'scores ≥ 8, or two consecutive scores ≥ 12.',

      // CNS group
      'cns.group.display': 'Central Nervous System',
      'cns.group.description':
          'Assess CNS disturbances including cry, sleep, reflexes, tremors, and tone.',

      'cry.display': 'Cry',
      'cry.description': 'Select the most severe cry observed.',
      'cry.0': 'Normal cry',
      'cry.2': 'High-pitched cry',
      'cry.3': 'Continuous high-pitched cry',

      'sleep.display': 'Sleep after feeding',
      'sleep.description': 'Select the shortest sleep interval observed.',
      'sleep.0': 'Sleeps > 3 h',
      'sleep.1': 'Sleeps < 3 h',
      'sleep.2': 'Sleeps < 2 h',
      'sleep.3': 'Sleeps < 1 h',

      'moro.display': 'Moro reflex',
      'moro.description': 'Assess the intensity of the Moro reflex.',
      'moro.0': 'Normal Moro reflex',
      'moro.2': 'Hyperactive Moro reflex',
      'moro.3': 'Markedly hyperactive Moro reflex',

      'tremors.display': 'Tremors',
      'tremors.description':
          'Observe the infant both disturbed and undisturbed; record the '
          'single highest applicable tier (do not add disturbed and '
          'undisturbed scores together).',
      'tremors.0': 'No tremors',
      'tremors.1': 'Mild tremors when disturbed',
      'tremors.2': 'Moderate–severe tremors when disturbed',
      'tremors.3': 'Mild tremors when undisturbed',
      'tremors.4': 'Moderate–severe tremors when undisturbed',

      'muscle-tone.display': 'Increased muscle tone',
      'muscle-tone.description': 'Hypertonia on passive movement.',

      'excoriation.display': 'Excoriation',
      'excoriation.description': 'Skin excoriation (chin, knees, toes, nose).',

      'myoclonic-jerks.display': 'Myoclonic jerks',
      'myoclonic-jerks.description': 'Twitching / myoclonic jerks observed.',

      'convulsions.display': 'Generalized convulsions',
      'convulsions.description': 'Generalised convulsions observed.',

      // MVR group
      'mvr.group.display': 'Metabolic / Vasomotor / Respiratory',
      'mvr.group.description':
          'Assess signs of autonomic dysfunction and respiratory distress.',

      'sweating.display': 'Sweating',
      'sweating.description': 'Excessive sweating not explained by overheating.',

      'fever.display': 'Fever',
      'fever.description': 'Select the highest temperature recorded.',
      'fever.0': 'No fever (< 37.2 °C)',
      'fever.1': 'Low-grade fever (37.2–38.3 °C)',
      'fever.2': 'High fever (> 38.3 °C)',

      'yawning.display': 'Yawning',
      'yawning.description': '> 3–4 yawns per assessment interval.',

      'mottling.display': 'Mottling',
      'mottling.description': 'Mottled skin appearance.',

      'nasal-stuffiness.display': 'Nasal stuffiness',
      'nasal-stuffiness.description': 'Nasal congestion or stuffiness.',

      'sneezing.display': 'Sneezing',
      'sneezing.description': '> 3–4 sneezes per assessment interval.',

      'nasal-flaring.display': 'Nasal flaring',
      'nasal-flaring.description': 'Nasal flaring during respiration.',

      'respiratory-rate.display': 'Respiratory rate',
      'respiratory-rate.description':
          'Select the highest rate observed. Retractions (intercostal or '
          'subcostal) are the top tier of this item, not a separate score.',
      'respiratory-rate.0': 'Normal (≤ 60 /min)',
      'respiratory-rate.1': '> 60 /min, no retractions',
      'respiratory-rate.2': '> 60 /min with retractions',

      // GI group
      'gi.group.display': 'Gastrointestinal',
      'gi.group.description': 'Assess feeding difficulties and GI signs.',

      'sucking.display': 'Excessive sucking',
      'sucking.description': 'Frantic or excessive non-nutritive sucking.',

      'feeding.display': 'Poor feeding',
      'feeding.description': 'Incoordinated or poor sucking during feeds.',

      'regurgitation.display': 'Regurgitation',
      'regurgitation.description': 'Regurgitation after feeding.',

      'vomiting.display': 'Projectile vomiting',
      'vomiting.description': 'Projectile vomiting after feeding.',

      'stools.display': 'Stool consistency',
      'stools.description': 'Select the worst stool consistency observed.',
      'stools.0': 'Normal stools',
      'stools.2': 'Loose stools',
      'stools.3': 'Watery stools',
      // Calculation output
      'calc.incomplete': 'Complete at least one item to calculate the score.',
      'calc.partialLabel': 'Finnegan NAS (partial)',
      'calc.itemsNotAssessed': '{n} item(s) not yet assessed.',
      'calc.interp.mild':
          'Mild / no withdrawal — supportive care, reassess at next feed',
      'calc.interp.moderate':
          'Moderate withdrawal — intensify non-pharmacological measures; '
          'pharmacotherapy if 3 consecutive scores ≥ 8',
      'calc.interp.severe':
          'Severe withdrawal — pharmacotherapy indicated if 2 consecutive '
          'scores ≥ 12; consult neonatology',
      'calc.domainLabel': 'CNS / MVR / GI',
    },
    'de': {
      'display': 'Finnegan NAS',
      'description':
          'Finnegan Neonatal Abstinence Score — bewertet den Entzugsschweregrad '
          'bei Neugeborenen mit pränataler Opioidexposition (21 Items, '
          'Maximum 46). Eine pharmakologische Behandlung wird in der Regel '
          'erwogen bei drei aufeinanderfolgenden Scores ≥ 8 oder zwei '
          'aufeinanderfolgenden Scores ≥ 12.',

      // CNS group
      'cns.group.display': 'Zentralnervensystem',
      'cns.group.description':
          'ZNS-Störungen: Schreien, Schlaf, Reflexe, Tremor und Muskeltonus.',

      'cry.display': 'Schreien',
      'cry.description': 'Schlimmstes beobachtetes Schreien auswählen.',
      'cry.0': 'Normales Schreien',
      'cry.2': 'Hochfrequentes Schreien',
      'cry.3': 'Anhaltendes hochfrequentes Schreien',

      'sleep.display': 'Schlaf nach der Mahlzeit',
      'sleep.description': 'Kürzestes beobachtetes Schlafintervall auswählen.',
      'sleep.0': 'Schläft > 3 h',
      'sleep.1': 'Schläft < 3 h',
      'sleep.2': 'Schläft < 2 h',
      'sleep.3': 'Schläft < 1 h',

      'moro.display': 'Moro-Reflex',
      'moro.description': 'Intensität des Moro-Reflexes beurteilen.',
      'moro.0': 'Normaler Moro-Reflex',
      'moro.2': 'Hyperaktiver Moro-Reflex',
      'moro.3': 'Deutlich hyperaktiver Moro-Reflex',

      'tremors.display': 'Tremor',
      'tremors.description':
          'Das Kind sowohl gestört als auch ungestört beobachten und die '
          'jeweils höchste zutreffende Stufe eintragen (die Werte für '
          'gestört/ungestört nicht addieren).',
      'tremors.0': 'Kein Tremor',
      'tremors.1': 'Leichter Tremor bei Störung',
      'tremors.2': 'Mäßiger bis starker Tremor bei Störung',
      'tremors.3': 'Leichter Tremor in Ruhe',
      'tremors.4': 'Mäßiger bis starker Tremor in Ruhe',

      'muscle-tone.display': 'Erhöhter Muskeltonus',
      'muscle-tone.description': 'Hypertonie bei passiver Bewegung.',

      'excoriation.display': 'Exkoriationen',
      'excoriation.description': 'Hautabschürfungen (Kinn, Knie, Zehen, Nase).',

      'myoclonic-jerks.display': 'Myoklonische Zuckungen',
      'myoclonic-jerks.description': 'Myoklonische Zuckungen beobachtet.',

      'convulsions.display': 'Generalisierte Krampfanfälle',
      'convulsions.description': 'Generalisierter Krampfanfall beobachtet.',

      // MVR group
      'mvr.group.display': 'Metabolisch / Vasomotorisch / Respiratorisch',
      'mvr.group.description':
          'Zeichen autonomer Dysregulation und respiratorischer Störungen.',

      'sweating.display': 'Schwitzen',
      'sweating.description': 'Übermäßiges Schwitzen, nicht durch Überwärmung erklärt.',

      'fever.display': 'Fieber',
      'fever.description': 'Höchste gemessene Temperatur auswählen.',
      'fever.0': 'Kein Fieber (< 37,2 °C)',
      'fever.1': 'Subfebrile Temperatur (37,2–38,3 °C)',
      'fever.2': 'Hohes Fieber (> 38,3 °C)',

      'yawning.display': 'Gähnen',
      'yawning.description': '> 3–4 Gähnvorgänge pro Beurteilungsintervall.',

      'mottling.display': 'Marmorierung',
      'mottling.description': 'Marmoriertes Hautbild.',

      'nasal-stuffiness.display': 'Nasale Kongestion',
      'nasal-stuffiness.description': 'Verstopfte oder gereizte Nase.',

      'sneezing.display': 'Niesen',
      'sneezing.description': '> 3–4 Niesvorgänge pro Beurteilungsintervall.',

      'nasal-flaring.display': 'Nasenflügeln',
      'nasal-flaring.description': 'Nasenflügeln beim Atmen.',

      'respiratory-rate.display': 'Atemfrequenz',
      'respiratory-rate.description':
          'Höchste beobachtete Atemfrequenz auswählen. Einziehungen '
          '(interkostal oder subkostal) sind die oberste Stufe dieses '
          'Items, kein separater Punktwert.',
      'respiratory-rate.0': 'Normal (≤ 60 /min)',
      'respiratory-rate.1': '> 60 /min, keine Einziehungen',
      'respiratory-rate.2': '> 60 /min mit Einziehungen',

      // GI group
      'gi.group.display': 'Gastrointestinal',
      'gi.group.description': 'Ernährungsschwierigkeiten und gastrointestinale Zeichen.',

      'sucking.display': 'Übermäßiges Saugen',
      'sucking.description': 'Exzessives, unkoordiniertes nichtnutritives Saugen.',

      'feeding.display': 'Trinkschwäche',
      'feeding.description': 'Unkoordiniertes oder schwaches Saugen bei der Mahlzeit.',

      'regurgitation.display': 'Regurgitation',
      'regurgitation.description': 'Regurgitation nach der Mahlzeit.',

      'vomiting.display': 'Erbrechen im Schwall',
      'vomiting.description': 'Schwallartig-projizierendes Erbrechen nach der Mahlzeit.',

      'stools.display': 'Stuhlkonsistenz',
      'stools.description': 'Schlechteste beobachtete Stuhlkonsistenz auswählen.',
      'stools.0': 'Normaler Stuhl',
      'stools.2': 'Breiiger Stuhl',
      'stools.3': 'Wässriger Stuhl',
      // Calculation output
      'calc.incomplete':
          'Mindestens ein Item ausfüllen, um den Score zu berechnen.',
      'calc.partialLabel': 'Finnegan NAS (unvollständig)',
      'calc.itemsNotAssessed': '{n} Item(s) noch nicht beurteilt.',
      'calc.interp.mild':
          'Leichter oder kein Entzug — supportive Behandlung, '
          'Reassessment bei nächster Mahlzeit',
      'calc.interp.moderate':
          'Moderater Entzug — nicht-medikamentöse Maßnahmen intensivieren; '
          'medikamentöse Behandlung bei 3 aufeinanderfolgenden Scores ≥ 8',
      'calc.interp.severe':
          'Schwerer Entzug — medikamentöse Behandlung indiziert bei 2 '
          'aufeinanderfolgenden Scores ≥ 12; Neonatologie hinzuziehen',
      'calc.domainLabel': 'ZNS / MVR / GI',
    },
  };
}

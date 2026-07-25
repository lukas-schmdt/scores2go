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
          'Rate each item based on observations during the current shift.',
      'disorientation.display': 'Disorientation',
      'disorientation.description':
          'Patient appears confused about time, place, or person (e.g. does not recognise surroundings or hospital staff).',
      'inappropriate-behavior.display': 'Inappropriate behavior',
      'inappropriate-behavior.description':
          'Patient picks at tubes/catheters, attempts to get out of bed inappropriately, or is uncooperative.',
      'inappropriate-communication.display': 'Inappropriate communication',
      'inappropriate-communication.description':
          'Incoherent, disorganised, or unintelligible speech; mumbling; unusual sounds.',
      'illusions.display': 'Illusions / hallucinations',
      'illusions.description':
          'Patient sees or hears things that are not present.',
      'psychomotor-retardation.display': 'Psychomotor retardation',
      'psychomotor-retardation.description':
          'Slowed reaction, few or no spontaneous movements, delayed response to stimulation.',
      'opt.absent': 'Absent',
      'opt.mild': 'Mild / intermittent',
      'opt.present': 'Present / pronounced',
      // Calculation output
      'calc.incomplete': 'Please rate all 5 items to obtain a score.',
      'calc.interp.0': 'No delirium detected.',
      'calc.interp.1': 'No delirium detected (borderline — reassess regularly).',
      'calc.interp.2to4':
          'Delirium likely (score ≥ 2) — further clinical assessment recommended.',
      'calc.interp.severe':
          'Severe delirium likely — immediate clinical assessment required.',
    },
    'de': {
      'display': 'Nu-DESC',
      'description':
          'Nursing Delirium Screening Scale — ein kurzes 5-Punkte-Instrument zur pflegerischen Delir-Erfassung.',
      'group.display': 'Beurteilung',
      'group.description':
          'Jedes Item anhand der Beobachtungen der aktuellen Schicht bewerten.',
      'disorientation.display': 'Orientierungsstörung',
      'disorientation.description':
          'Patient wirkt zeitlich, örtlich oder zur Person desorientiert (erkennt Umgebung oder Pflegepersonal nicht).',
      'inappropriate-behavior.display': 'Unangemessenes Verhalten',
      'inappropriate-behavior.description':
          'Patient zieht Zugänge/Katheter, versucht das Bett unangemessen zu verlassen, ist unkooperativ.',
      'inappropriate-communication.display': 'Unangemessene Kommunikation',
      'inappropriate-communication.description':
          'Inkohärente, desorganisierte oder unverständliche Sprache; Murmeln; ungewöhnliche Laute.',
      'illusions.display': 'Illusionen / Halluzinationen',
      'illusions.description':
          'Patient sieht oder hört Dinge, die nicht vorhanden sind.',
      'psychomotor-retardation.display': 'Psychomotorische Verlangsamung',
      'psychomotor-retardation.description':
          'Verlangsamte Reaktion, kaum oder keine Spontanbewegungen, verzögerte Antwort auf Reize.',
      'opt.absent': 'Nicht vorhanden',
      'opt.mild': 'Leicht / intermittierend',
      'opt.present': 'Ausgeprägt / durchgehend',
      // Calculation output
      'calc.incomplete': 'Bitte alle 5 Items bewerten, um einen Score zu erhalten.',
      'calc.interp.0': 'Kein Delir festgestellt.',
      'calc.interp.1':
          'Kein Delir festgestellt (Grenzbereich — regelmäßig neu beurteilen).',
      'calc.interp.2to4':
          'Delir wahrscheinlich (Score ≥ 2) — weitere klinische Abklärung empfohlen.',
      'calc.interp.severe':
          'Schweres Delir wahrscheinlich — sofortige klinische Abklärung erforderlich.',
    },
  };
}

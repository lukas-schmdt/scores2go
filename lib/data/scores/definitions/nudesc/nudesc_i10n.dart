import 'package:scores_2_go/l10n/score_i10n.dart';

class NudescI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'Nu-DESC',
      'description': 'Nursing Delirium Screening Scale — a brief 5-item nurse-rated tool for delirium screening.',
      'group.display': 'Assessment',
      'group.description': 'Rate each item based on observations during the current shift.',
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
      'opt.absent': '0 – Absent',
      'opt.mild': '1 – Mild / intermittent',
      'opt.present': '2 – Present / pronounced',
    },
    'de': {
      'display': 'Nu-DESC',
      'description': 'Nursing Delirium Screening Scale — ein kurzes 5-Punkte-Instrument zur pflegerischen Delir-Erfassung.',
      'group.display': 'Beurteilung',
      'group.description': 'Jedes Item anhand der Beobachtungen der aktuellen Schicht bewerten.',
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
      'opt.absent': '0 – Nicht vorhanden',
      'opt.mild': '1 – Leicht / intermittierend',
      'opt.present': '2 – Ausgeprägt / durchgehend',
    },
  };
}

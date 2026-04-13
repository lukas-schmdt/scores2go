import 'package:scores_2_go/l10n/score_i10n.dart';

class HorovitzI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'Horovitz Quotient',
      'description':
          'PaO₂ / FiO₂ ratio — quantifies oxygenation impairment and classifies '
          'ARDS severity according to the Berlin Definition.',

      'oxygenation.group.display': 'Oxygenation',
      'oxygenation.group.description':
          'Enter the arterial partial pressure of oxygen and the inspired '
          'oxygen fraction. The ratio is calculated automatically.',

      'pao2.display': 'PaO₂',
      'pao2.description':
          'Arterial partial pressure of oxygen from blood gas analysis.',

      'fio2.display': 'FiO₂',
      'fio2.description':
          'Fraction of inspired oxygen. Enter as percentage (e.g. 40 for 40 %).',
    },
    'de': {
      'display': 'Horovitz-Quotient',
      'description':
          'PaO₂ / FiO₂-Quotient — quantifiziert die Oxygenierungsstörung und '
          'klassifiziert den ARDS-Schweregrad nach der Berlin-Definition.',

      'oxygenation.group.display': 'Oxygenierung',
      'oxygenation.group.description':
          'Arteriellen Sauerstoffpartialdruck und Sauerstoffkonzentration eingeben. '
          'Der Quotient wird automatisch berechnet.',

      'pao2.display': 'PaO₂',
      'pao2.description':
          'Arterieller Sauerstoffpartialdruck aus der Blutgasanalyse.',

      'fio2.display': 'FiO₂',
      'fio2.description':
          'Inspiratorische Sauerstofffraktion. Als Prozent eingeben (z. B. 40 für 40 %).',
    },
  };
}

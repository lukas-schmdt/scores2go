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
      // Calculation output
      'calc.incomplete.enterBoth': 'Enter PaO₂ and FiO₂ to calculate the ratio.',
      'calc.incomplete.pao2Missing': 'PaO₂ is missing.',
      'calc.incomplete.fio2Missing': 'FiO₂ is missing.',
      'calc.fio2MustBeGreaterThanZero': 'FiO₂ must be greater than 0 %.',
      'calc.inputsLabel': 'Inputs',
      'calc.interp.normal': 'Normal oxygenation (≥ 400)',
      'calc.interp.mildHypoxemia': 'Mild hypoxemia (300–399)',
      'calc.interp.mildArds': 'Mild ARDS — Berlin Definition (200–299)',
      'calc.interp.moderateArds':
          'Moderate ARDS — Berlin Definition (100–199)',
      'calc.interp.severeArds': 'Severe ARDS — Berlin Definition (< 100)',
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
      // Calculation output
      'calc.incomplete.enterBoth':
          'PaO₂ und FiO₂ eingeben, um den Quotienten zu berechnen.',
      'calc.incomplete.pao2Missing': 'PaO₂ fehlt.',
      'calc.incomplete.fio2Missing': 'FiO₂ fehlt.',
      'calc.fio2MustBeGreaterThanZero': 'FiO₂ muss größer als 0 % sein.',
      'calc.inputsLabel': 'Eingaben',
      'calc.interp.normal': 'Normale Oxygenierung (≥ 400)',
      'calc.interp.mildHypoxemia': 'Leichte Hypoxämie (300–399)',
      'calc.interp.mildArds': 'Leichtes ARDS — Berlin-Definition (200–299)',
      'calc.interp.moderateArds':
          'Moderates ARDS — Berlin-Definition (100–199)',
      'calc.interp.severeArds': 'Schweres ARDS — Berlin-Definition (< 100)',
    },
  };
}

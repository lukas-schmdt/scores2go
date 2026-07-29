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

      'peep.display': 'PEEP',
      'peep.description':
          'Positive end-expiratory pressure (or CPAP level). Optional — '
          'entering it enables the formal Berlin ARDS classification, which '
          'is only valid at PEEP/CPAP ≥ 5 cmH₂O. Leave blank if unknown.',

      // Calculation output
      'calc.incomplete.enterBoth': 'Enter PaO₂ and FiO₂ to calculate the ratio.',
      'calc.incomplete.pao2Missing': 'PaO₂ is missing.',
      'calc.incomplete.fio2Missing': 'FiO₂ is missing.',
      'calc.fio2MustBeGreaterThanZero': 'FiO₂ must be greater than 0 %.',
      'calc.inputsLabel': 'Inputs',

      'calc.interp.normal': 'Normal oxygenation (≥ 400)',
      'calc.interp.mildImpairment': 'Mild impairment (300 < P/F < 400)',

      'calc.interp.mildArds.full':
          'Mild ARDS — Berlin Definition (200 < P/F ≤ 300)',
      'calc.interp.mildArds.peepLow':
          'Mild ARDS range (200 < P/F ≤ 300) — Berlin classification does '
          'not apply: PEEP/CPAP is below 5 cmH₂O.',
      'calc.interp.mildArds.peepUnknown':
          'Mild ARDS range (200 < P/F ≤ 300) — Berlin classification '
          'additionally requires PEEP/CPAP ≥ 5 cmH₂O.',

      'calc.interp.moderateArds.full':
          'Moderate ARDS — Berlin Definition (100 < P/F ≤ 200)',
      'calc.interp.moderateArds.peepLow':
          'Moderate ARDS range (100 < P/F ≤ 200) — Berlin classification '
          'does not apply: PEEP/CPAP is below 5 cmH₂O.',
      'calc.interp.moderateArds.peepUnknown':
          'Moderate ARDS range (100 < P/F ≤ 200) — Berlin classification '
          'additionally requires PEEP/CPAP ≥ 5 cmH₂O.',

      'calc.interp.severeArds.full':
          'Severe ARDS — Berlin Definition (P/F ≤ 100)',
      'calc.interp.severeArds.peepLow':
          'Severe ARDS range (P/F ≤ 100) — Berlin classification does not '
          'apply: PEEP/CPAP is below 5 cmH₂O.',
      'calc.interp.severeArds.peepUnknown':
          'Severe ARDS range (P/F ≤ 100) — Berlin classification '
          'additionally requires PEEP/CPAP ≥ 5 cmH₂O.',
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

      'peep.display': 'PEEP',
      'peep.description':
          'Positiver endexspiratorischer Druck (bzw. CPAP-Niveau). Optional — '
          'die Angabe ermöglicht die formale Berlin-ARDS-Klassifikation, die '
          'nur bei PEEP/CPAP ≥ 5 cmH₂O gültig ist. Bei Unbekanntem leer lassen.',

      // Calculation output
      'calc.incomplete.enterBoth':
          'PaO₂ und FiO₂ eingeben, um den Quotienten zu berechnen.',
      'calc.incomplete.pao2Missing': 'PaO₂ fehlt.',
      'calc.incomplete.fio2Missing': 'FiO₂ fehlt.',
      'calc.fio2MustBeGreaterThanZero': 'FiO₂ muss größer als 0 % sein.',
      'calc.inputsLabel': 'Eingaben',

      'calc.interp.normal': 'Normale Oxygenierung (≥ 400)',
      'calc.interp.mildImpairment': 'Leichte Einschränkung (300 < P/F < 400)',

      'calc.interp.mildArds.full':
          'Leichtes ARDS — Berlin-Definition (200 < P/F ≤ 300)',
      'calc.interp.mildArds.peepLow':
          'Bereich leichtes ARDS (200 < P/F ≤ 300) — Berlin-Klassifikation '
          'nicht anwendbar: PEEP/CPAP liegt unter 5 cmH₂O.',
      'calc.interp.mildArds.peepUnknown':
          'Bereich leichtes ARDS (200 < P/F ≤ 300) — Berlin-Klassifikation '
          'erfordert zusätzlich PEEP/CPAP ≥ 5 cmH₂O.',

      'calc.interp.moderateArds.full':
          'Moderates ARDS — Berlin-Definition (100 < P/F ≤ 200)',
      'calc.interp.moderateArds.peepLow':
          'Bereich moderates ARDS (100 < P/F ≤ 200) — Berlin-Klassifikation '
          'nicht anwendbar: PEEP/CPAP liegt unter 5 cmH₂O.',
      'calc.interp.moderateArds.peepUnknown':
          'Bereich moderates ARDS (100 < P/F ≤ 200) — Berlin-Klassifikation '
          'erfordert zusätzlich PEEP/CPAP ≥ 5 cmH₂O.',

      'calc.interp.severeArds.full':
          'Schweres ARDS — Berlin-Definition (P/F ≤ 100)',
      'calc.interp.severeArds.peepLow':
          'Bereich schweres ARDS (P/F ≤ 100) — Berlin-Klassifikation nicht '
          'anwendbar: PEEP/CPAP liegt unter 5 cmH₂O.',
      'calc.interp.severeArds.peepUnknown':
          'Bereich schweres ARDS (P/F ≤ 100) — Berlin-Klassifikation '
          'erfordert zusätzlich PEEP/CPAP ≥ 5 cmH₂O.',
    },
  };
}

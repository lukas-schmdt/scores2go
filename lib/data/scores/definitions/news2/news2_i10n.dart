import 'package:scores_2_go/l10n/score_i10n.dart';

class News2I10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'NEWS2',
      'description':
          'National Early Warning Score 2 — standardises acute illness severity '
          'assessment using 7 physiological parameters. Widely adopted in UK '
          'hospitals for early detection of clinical deterioration.',

      'group.respiratory.display': 'Respiratory',
      'group.respiratory.description':
          'Respiratory rate, oxygen saturation and supplemental oxygen use.',
      'group.cardiovascular.display': 'Cardiovascular',
      'group.cardiovascular.description': 'Systolic blood pressure and pulse rate.',
      'group.neuro.display': 'Consciousness & Temperature',
      'group.neuro.description': 'Level of consciousness (ACVPU) and body temperature.',

      'rr.display': 'Respiration Rate',
      'rr.description': 'Breaths per minute (normal: 12–20 /min).',
      'rr.opt.le8': '≤ 8 /min',
      'rr.opt.9to11': '9–11 /min',
      'rr.opt.12to20': '12–20 /min',
      'rr.opt.21to24': '21–24 /min',
      'rr.opt.ge25': '≥ 25 /min',

      'hypercapnic.display': 'Hypercapnic Respiratory Failure Risk',
      'hypercapnic.description':
          'Patient has confirmed or at risk of hypercapnic respiratory failure '
          '(e.g. COPD, neuromuscular disease). YES → use SpO₂ Scale 2 (target 88–92%).',

      'spo2-1.display': 'SpO₂ — Scale 1',
      'spo2-1.description':
          'Standard scale for most patients (target SpO₂ ≥ 96%).',
      'spo2-1.opt.le91': '≤ 91%',
      'spo2-1.opt.92to93': '92–93%',
      'spo2-1.opt.94to95': '94–95%',
      'spo2-1.opt.ge96': '≥ 96%',

      'spo2-2.display': 'SpO₂ — Scale 2',
      'spo2-2.description':
          'For hypercapnic respiratory failure risk (target SpO₂ 88–92%).',
      'spo2-2.opt.le83': '≤ 83%',
      'spo2-2.opt.84to85': '84–85%',
      'spo2-2.opt.86to87': '86–87%',
      'spo2-2.opt.88to92': '88–92% (or ≥ 93% on air)',
      'spo2-2.opt.93to94o2': '93–94% on supplemental O₂',
      'spo2-2.opt.95to96o2': '95–96% on supplemental O₂',
      'spo2-2.opt.ge97o2': '≥ 97% on supplemental O₂',

      'o2.display': 'Supplemental Oxygen',
      'o2.description':
          'Is the patient receiving supplemental oxygen (any delivery device)?',

      'sbp.display': 'Systolic Blood Pressure',
      'sbp.description': 'Systolic BP in mmHg (normal: 111–219 mmHg).',
      'sbp.opt.le90': '≤ 90 mmHg',
      'sbp.opt.91to100': '91–100 mmHg',
      'sbp.opt.101to110': '101–110 mmHg',
      'sbp.opt.111to219': '111–219 mmHg',
      'sbp.opt.ge220': '≥ 220 mmHg',

      'pulse.display': 'Pulse Rate',
      'pulse.description': 'Heart rate in beats per minute (normal: 51–90 /min).',
      'pulse.opt.le40': '≤ 40 /min',
      'pulse.opt.41to50': '41–50 /min',
      'pulse.opt.51to90': '51–90 /min',
      'pulse.opt.91to110': '91–110 /min',
      'pulse.opt.111to130': '111–130 /min',
      'pulse.opt.ge131': '≥ 131 /min',

      'consciousness.display': 'Consciousness (ACVPU)',
      'consciousness.description':
          'Level of consciousness using ACVPU scale. C = new confusion or delirium.',
      'consciousness.opt.a': 'A — Alert',
      'consciousness.opt.c': 'C — New Confusion / Delirium',
      'consciousness.opt.v': 'V — Responds to Voice',
      'consciousness.opt.p': 'P — Responds to Pain',
      'consciousness.opt.u': 'U — Unresponsive',

      'temp.display': 'Temperature',
      'temp.description': 'Body temperature in °C (normal: 36.1–38.0 °C).',
      'temp.opt.le35': '≤ 35.0 °C',
      'temp.opt.35to36': '35.1–36.0 °C',
      'temp.opt.36to38': '36.1–38.0 °C',
      'temp.opt.38to39': '38.1–39.0 °C',
      'temp.opt.ge39': '≥ 39.1 °C',
    },
    'de': {
      'display': 'NEWS2',
      'description':
          'National Early Warning Score 2 — standardisiert die Einschätzung des '
          'Schweregrads akuter Erkrankungen anhand von 7 physiologischen Parametern. '
          'Weit verbreitet in britischen Kliniken zur Früherkennung klinischer Verschlechterung.',

      'group.respiratory.display': 'Atmung',
      'group.respiratory.description':
          'Atemfrequenz, Sauerstoffsättigung und Sauerstoffzufuhr.',
      'group.cardiovascular.display': 'Kreislauf',
      'group.cardiovascular.description': 'Systolischer Blutdruck und Pulsfrequenz.',
      'group.neuro.display': 'Bewusstsein & Temperatur',
      'group.neuro.description': 'Bewusstseinsgrad (ACVPU) und Körpertemperatur.',

      'rr.display': 'Atemfrequenz',
      'rr.description': 'Atemzüge pro Minute (Norm: 12–20 /min).',
      'rr.opt.le8': '≤ 8 /min',
      'rr.opt.9to11': '9–11 /min',
      'rr.opt.12to20': '12–20 /min',
      'rr.opt.21to24': '21–24 /min',
      'rr.opt.ge25': '≥ 25 /min',

      'hypercapnic.display': 'Hyperkapnisches Atemversagen (Risiko)',
      'hypercapnic.description':
          'Patient mit gesichertem oder Risiko eines hyperkapnischen Atemversagens '
          '(z. B. COPD, neuromuskuläre Erkrankung). JA → SpO₂-Skala 2 verwenden (Ziel 88–92%).',

      'spo2-1.display': 'SpO₂ — Skala 1',
      'spo2-1.description':
          'Standardskala für die meisten Patienten (Ziel SpO₂ ≥ 96%).',
      'spo2-1.opt.le91': '≤ 91 %',
      'spo2-1.opt.92to93': '92–93 %',
      'spo2-1.opt.94to95': '94–95 %',
      'spo2-1.opt.ge96': '≥ 96 %',

      'spo2-2.display': 'SpO₂ — Skala 2',
      'spo2-2.description':
          'Für hyperkapnisches Atemversagen (Ziel SpO₂ 88–92%).',
      'spo2-2.opt.le83': '≤ 83 %',
      'spo2-2.opt.84to85': '84–85 %',
      'spo2-2.opt.86to87': '86–87 %',
      'spo2-2.opt.88to92': '88–92 % (oder ≥ 93 % an Raumluft)',
      'spo2-2.opt.93to94o2': '93–94 % unter Sauerstoff',
      'spo2-2.opt.95to96o2': '95–96 % unter Sauerstoff',
      'spo2-2.opt.ge97o2': '≥ 97 % unter Sauerstoff',

      'o2.display': 'Sauerstoffzufuhr',
      'o2.description':
          'Erhält der Patient Sauerstoff (über jedes Applikationssystem)?',

      'sbp.display': 'Systolischer Blutdruck',
      'sbp.description': 'Systolischer BD in mmHg (Norm: 111–219 mmHg).',
      'sbp.opt.le90': '≤ 90 mmHg',
      'sbp.opt.91to100': '91–100 mmHg',
      'sbp.opt.101to110': '101–110 mmHg',
      'sbp.opt.111to219': '111–219 mmHg',
      'sbp.opt.ge220': '≥ 220 mmHg',

      'pulse.display': 'Pulsfrequenz',
      'pulse.description': 'Herzfrequenz in Schlägen pro Minute (Norm: 51–90 /min).',
      'pulse.opt.le40': '≤ 40 /min',
      'pulse.opt.41to50': '41–50 /min',
      'pulse.opt.51to90': '51–90 /min',
      'pulse.opt.91to110': '91–110 /min',
      'pulse.opt.111to130': '111–130 /min',
      'pulse.opt.ge131': '≥ 131 /min',

      'consciousness.display': 'Bewusstsein (ACVPU)',
      'consciousness.description':
          'Bewusstseinsgrad nach ACVPU-Skala. C = neu aufgetretene Verwirrtheit oder Delir.',
      'consciousness.opt.a': 'A — Wach (Alert)',
      'consciousness.opt.c': 'C — Neue Verwirrtheit / Delir',
      'consciousness.opt.v': 'V — Reaktion auf Ansprache',
      'consciousness.opt.p': 'P — Reaktion auf Schmerz',
      'consciousness.opt.u': 'U — Reaktionslos (Unresponsive)',

      'temp.display': 'Körpertemperatur',
      'temp.description': 'Körpertemperatur in °C (Norm: 36,1–38,0 °C).',
      'temp.opt.le35': '≤ 35,0 °C',
      'temp.opt.35to36': '35,1–36,0 °C',
      'temp.opt.36to38': '36,1–38,0 °C',
      'temp.opt.38to39': '38,1–39,0 °C',
      'temp.opt.ge39': '≥ 39,1 °C',
    },
  };
}

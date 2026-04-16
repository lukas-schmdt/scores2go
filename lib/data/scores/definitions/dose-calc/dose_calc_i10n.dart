import 'package:scores_2_go/l10n/score_i10n.dart';

class DoseCalcI10n extends ScoreI10n {
  @override
  Map<String, Map<String, String>> get strings => _strings;

  static const _strings = {
    'en': {
      'display': 'Dose Calculator',
      'description': 'Converts between pump rate (ml/h) and weight-adjusted dose — supports µg, mg and IU with /min, /h time units.',

      'group.setup': 'Patient & Drug',
      'group.setup.description': 'Enter body weight and drug concentration.',
      'group.mode': 'Mode',
      'group.mode.description': '',
      'group.dose': 'Dose Input',
      'group.dose.description': '',
      'group.rate': 'Rate Input',
      'group.rate.description': '',

      'weight.display': 'Body weight',
      'weight.description': '',
      'conc-amount.display': 'Drug amount',
      'conc-amount.description': 'Total amount of drug in the syringe or bag.',
      'conc-volume.display': 'Total volume',
      'conc-volume.description': 'Total fill volume of the syringe or bag.',

      'mode.display': 'Calculation mode',
      'mode.description': '',
      'mode.dose-to-rate': 'Dose → Rate',
      'mode.dose-to-rate.desc': 'Enter target dose, get pump rate (ml/h)',
      'mode.rate-to-dose': 'Rate → Dose',
      'mode.rate-to-dose.desc': 'Enter pump rate (ml/h), get dose per kg',

      'dose.display': 'Target dose',
      'dose.description': 'Tap the unit chip to switch between µg/kg/min, µg/kg/h, mg/kg/min, mg/kg/h, IU/kg/min, IU/kg/h.',
      'rate.display': 'Pump rate',
      'rate.description': '',
    },
    'de': {
      'display': 'Dosisrechner',
      'description': 'Rechnet zwischen Laufrate (ml/h) und gewichtsadaptierter Dosis um — unterstützt µg, mg und IU mit /min und /h.',

      'group.setup': 'Patient & Medikament',
      'group.setup.description': 'Körpergewicht und Wirkstoffkonzentration eingeben.',
      'group.mode': 'Modus',
      'group.mode.description': '',
      'group.dose': 'Dosiseingabe',
      'group.dose.description': '',
      'group.rate': 'Lauffrateeingabe',
      'group.rate.description': '',

      'weight.display': 'Körpergewicht',
      'weight.description': '',
      'conc-amount.display': 'Wirkstoffmenge',
      'conc-amount.description': 'Gesamtmenge des Wirkstoffs in der Spritze oder im Beutel.',
      'conc-volume.display': 'Gesamtvolumen',
      'conc-volume.description': 'Gesamtfüllvolumen der Spritze oder des Beutels.',

      'mode.display': 'Berechnungsmodus',
      'mode.description': '',
      'mode.dose-to-rate': 'Dosis → Laufrate',
      'mode.dose-to-rate.desc': 'Zieldosis eingeben → Laufrate (ml/h) berechnen',
      'mode.rate-to-dose': 'Laufrate → Dosis',
      'mode.rate-to-dose.desc': 'Laufrate (ml/h) eingeben → Dosis/kg berechnen',

      'dose.display': 'Zieldosis',
      'dose.description': 'Einheit per Chip wechseln: µg/kg/min, µg/kg/h, mg/kg/min, mg/kg/h, IU/kg/min, IU/kg/h.',
      'rate.display': 'Laufrate',
      'rate.description': '',
    },
  };
}

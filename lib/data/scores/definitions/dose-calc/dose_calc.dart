import 'package:scores_2_go/data/scores/definitions/dose-calc/dose_calc_function.dart';
import 'package:scores_2_go/data/scores/definitions/dose-calc/dose_calc_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/dose-calc/dose_calc_visibility.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = DoseCalcI10n();

// Canonical unit for concentration amount: µg (index 0)
const _concAmountUnits = [
  UnitDefinition(label: 'µg', factor: 1.0),
  UnitDefinition(label: 'mg', factor: 0.001),   // display_mg = canonical_µg × 0.001
  UnitDefinition(label: 'IU', factor: 1.0),      // treated as 1:1 with µg
];

// Canonical unit for dose: µg/kg/min (index 0)
// display = canonical × factor
const _doseUnits = [
  UnitDefinition(label: 'µg/kg/min', factor: 1.0),
  UnitDefinition(label: 'µg/kg/h',   factor: 60.0),
  UnitDefinition(label: 'mg/kg/min', factor: 0.001),
  UnitDefinition(label: 'mg/kg/h',   factor: 0.06),
  UnitDefinition(label: 'IU/kg/min', factor: 1.0),
  UnitDefinition(label: 'IU/kg/h',   factor: 60.0),
];

Score buildDoseCalcScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 15,
    name: 'dose-calc',
    display: t('display'),
    description: t('description'),
    author: '',
    year: null,
    popularity: 80,
    categories: ['Calculator', 'ICU', 'Pharmacology'],
    doc: (_) => 'lib/data/scores/definitions/dose-calc/dose_calc_doc.md',
    scoreFunction: doseCalcFunction,
    visibilityFunction: doseCalcVisibility,
    groups: [
      // ── Patient & Drug setup ────────────────────────────────────────────────
      Group(
        name: 'dose-calc-setup',
        display: t('group.setup'),
        description: t('group.setup.description'),
        isVisible: true,
        items: [
          VariableNumber(
            name: 'dose-calc-weight',
            display: t('weight.display'),
            description: t('weight.description'),
            value: null,
            normMin: 10,
            normMax: 300,
            units: const [UnitDefinition(label: 'kg', factor: 1.0)],
          ),
          VariableNumber(
            name: 'dose-calc-conc-amount',
            display: t('conc-amount.display'),
            description: t('conc-amount.description'),
            value: null,
            normMin: 0,
            normMax: null,
            units: _concAmountUnits,
          ),
          VariableNumber(
            name: 'dose-calc-conc-volume',
            display: t('conc-volume.display'),
            description: t('conc-volume.description'),
            value: 50,
            normMin: 1,
            normMax: 1000,
            units: const [UnitDefinition(label: 'ml', factor: 1.0)],
          ),
        ],
      ),

      // ── Mode selection ──────────────────────────────────────────────────────
      Group(
        name: 'dose-calc-mode-group',
        display: t('group.mode'),
        description: t('group.mode.description'),
        isVisible: false,
        items: [
          VariableSelection(
            name: 'dose-calc-mode',
            display: t('mode.display'),
            description: t('mode.description'),
            type: VariableType.select,
            options: [
              VariableOption(
                display: t('mode.dose-to-rate'),
                description: t('mode.dose-to-rate.desc'),
                value: 1,
              ),
              VariableOption(
                display: t('mode.rate-to-dose'),
                description: t('mode.rate-to-dose.desc'),
                value: 2,
              ),
            ],
          ),
        ],
      ),

      // ── Dose input (visible when mode = dose→rate) ──────────────────────────
      Group(
        name: 'dose-calc-dose-group',
        display: t('group.dose'),
        description: t('group.dose.description'),
        isVisible: false,
        items: [
          VariableNumber(
            name: 'dose-calc-dose',
            display: t('dose.display'),
            description: t('dose.description'),
            value: null,
            normMin: 0,
            normMax: null,
            units: _doseUnits,
          ),
        ],
      ),

      // ── Rate input (visible when mode = rate→dose) ──────────────────────────
      Group(
        name: 'dose-calc-rate-group',
        display: t('group.rate'),
        description: t('group.rate.description'),
        isVisible: false,
        items: [
          VariableNumber(
            name: 'dose-calc-rate',
            display: t('rate.display'),
            description: t('rate.description'),
            value: null,
            normMin: 0,
            normMax: 999,
            units: const [UnitDefinition(label: 'ml/h', factor: 1.0)],
          ),
        ],
      ),
    ],
  );
}

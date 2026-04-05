import 'package:scores_2_go/model/unit_definition.dart';

/// Predefined unit sets for use in [VariableNumber.units].
///
/// The **first** entry in every list is always the canonical unit —
/// the unit in which values are stored and passed to score functions.
class Units {
  Units._();

  // ─── Temperature ───────────────────────────────────────────────────────────
  static const List<UnitDefinition> temperature = [
    UnitDefinition(label: '°C'),
    UnitDefinition(label: '°F', factor: 1.8, offset: 32),
  ];

  // ─── Blood glucose ─────────────────────────────────────────────────────────
  static const List<UnitDefinition> glucose = [
    UnitDefinition(label: 'mg/dL'),
    UnitDefinition(label: 'mmol/L', factor: 0.0555),
  ];

  // ─── Creatinine ────────────────────────────────────────────────────────────
  static const List<UnitDefinition> creatinine = [
    UnitDefinition(label: 'mg/dL'),
    UnitDefinition(label: 'µmol/L', factor: 88.4),
  ];

  // ─── Bilirubin ─────────────────────────────────────────────────────────────
  static const List<UnitDefinition> bilirubin = [
    UnitDefinition(label: 'mg/dL'),
    UnitDefinition(label: 'µmol/L', factor: 17.1),
  ];

  // ─── Urea / BUN ────────────────────────────────────────────────────────────
  static const List<UnitDefinition> urea = [
    UnitDefinition(label: 'mg/dL'),
    UnitDefinition(label: 'mmol/L', factor: 0.357),
  ];

  // ─── Pressure ──────────────────────────────────────────────────────────────
  static const List<UnitDefinition> pressure = [
    UnitDefinition(label: 'mmHg'),
    UnitDefinition(label: 'kPa', factor: 0.133322),
  ];

  // ─── Weight ────────────────────────────────────────────────────────────────
  static const List<UnitDefinition> weight = [
    UnitDefinition(label: 'kg'),
    UnitDefinition(label: 'lbs', factor: 2.20462),
  ];

  // ─── Height ────────────────────────────────────────────────────────────────
  static const List<UnitDefinition> height = [
    UnitDefinition(label: 'cm'),
    UnitDefinition(label: 'in', factor: 0.393701),
  ];

  // ─── Leukocytes ────────────────────────────────────────────────────────────
  // ×10³/µL and ×10⁹/L are numerically equivalent (factor = 1).
  static const List<UnitDefinition> leukocytes = [
    UnitDefinition(label: '×10³/µL'),
    UnitDefinition(label: '×10⁹/L', factor: 1),
  ];
}

/// A single unit within a convertible set for a [VariableNumber].
///
/// All values are stored internally in the *canonical* unit (the first entry
/// in [VariableNumber.units], i.e. index 0).
///
/// Conversion formulas:
///   display   = canonical * factor + offset
///   canonical = (display  - offset) / factor
class UnitDefinition {
  final String label;

  /// Multiply the canonical value by this to get the display value.
  final double factor;

  /// Add this after multiplying (e.g. °C → °F needs +32).
  final double offset;

  const UnitDefinition({
    required this.label,
    this.factor = 1.0,
    this.offset = 0.0,
  });

  /// Convert a canonical value to this unit's display value.
  num toDisplay(num canonical) => canonical * factor + offset;

  /// Convert a display value in this unit back to the canonical value.
  num toCanonical(num display) => (display - offset) / factor;
}

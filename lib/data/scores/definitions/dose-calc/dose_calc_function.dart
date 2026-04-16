import 'package:scores_2_go/function/score_items_to_map.dart';
import 'package:scores_2_go/model/score.dart';
import 'package:scores_2_go/model/score_result.dart';

ScoreResult doseCalcFunction(Score score) {
  final ctx = FlatScoreContext(score: score);

  final weight = ctx.numValue('dose-calc-weight')?['value'] as num?;
  final concAmount = ctx.numValue('dose-calc-conc-amount')?['value'] as num?; // canonical: µg
  final concVolume = ctx.numValue('dose-calc-conc-volume')?['value'] as num?; // ml
  final mode = ctx.singleSelect('dose-calc-mode')?['value'] as num?;

  if (weight == null || concAmount == null || concVolume == null || mode == null) {
    return ScoreResult.incomplete(
      label: 'Dosisrechner',
      interpretation: 'Gewicht, Wirkstoffmenge, Volumen und Modus angeben.',
    );
  }

  if (weight <= 0) {
    return ScoreResult.incomplete(
      label: 'Dosisrechner',
      interpretation: 'Körpergewicht muss größer als 0 sein.',
    );
  }

  if (concVolume <= 0) {
    return ScoreResult.incomplete(
      label: 'Dosisrechner',
      interpretation: 'Volumen muss größer als 0 sein.',
    );
  }

  // Concentration in canonical mass unit per ml (e.g. µg/ml)
  final concPerMl = concAmount / concVolume;

  if (mode == 1) {
    // ── Dose → Rate ──────────────────────────────────────────────────────────
    final dose = ctx.numValue('dose-calc-dose')?['value'] as num?; // canonical: µg/kg/min
    if (dose == null) {
      return ScoreResult.incomplete(
        label: 'Dosisrechner',
        interpretation: 'Zieldosis eingeben.',
      );
    }

    // rate (ml/h) = dose (µg/kg/min) × weight (kg) × 60 min/h / conc (µg/ml)
    final rate = dose * weight * 60.0 / concPerMl;

    return ScoreResult(
      state: ScoreState.success,
      primaryLabel: 'Laufrate',
      primaryResult: '${_fmt(rate)} ml/h',
      primaryInterpretation:
          'Konzentration: ${_fmt(concPerMl)} ${_concUnit(score)} / ml   ·   '
          'Gewicht: ${_fmt(weight)} kg',
    );
  } else {
    // ── Rate → Dose ──────────────────────────────────────────────────────────
    final rate = ctx.numValue('dose-calc-rate')?['value'] as num?; // ml/h
    if (rate == null) {
      return ScoreResult.incomplete(
        label: 'Dosisrechner',
        interpretation: 'Laufrate eingeben.',
      );
    }

    // dose (µg/kg/min) = rate (ml/h) × conc (µg/ml) / weight (kg) / 60
    final dosePerMin = rate * concPerMl / (weight * 60.0); // µg/kg/min
    final dosePerH = dosePerMin * 60.0;                    // µg/kg/h
    final dosePerMinMg = dosePerMin / 1000.0;              // mg/kg/min
    final dosePerHMg = dosePerH / 1000.0;                  // mg/kg/h

    final massUnit = _concUnit(score);

    // Pick the most human-readable primary result
    final (primary, primaryUnit) = _bestDoseUnit(dosePerMin, dosePerH, dosePerMinMg, dosePerHMg, massUnit);

    // Secondary: show all common equivalents
    final equivalents = _formatEquivalents(dosePerMin, dosePerH, dosePerMinMg, dosePerHMg, massUnit);

    return ScoreResult(
      state: ScoreState.success,
      primaryLabel: 'Dosis',
      primaryResult: '$primary $primaryUnit',
      primaryInterpretation:
          'Konzentration: ${_fmt(concPerMl)} $massUnit/ml   ·   Gewicht: ${_fmt(weight)} kg',
      secondaryLabel: 'Äquivalente',
      secondaryResult: equivalents,
    );
  }
}

/// Returns the mass unit label from the active unit of the concentration variable.
String _concUnit(Score score) {
  for (final group in score.groups) {
    for (final item in group.items) {
      if (item.name == 'dose-calc-conc-amount') {
        final v = item;
        // Access the active unit label via the variable's runtime type
        // We'll use a duck-typed approach via the variable_number import
        try {
          final dynamic dyn = v;
          final label = dyn.activeUnit?.label as String?;
          return label ?? 'µg';
        } catch (_) {
          return 'µg';
        }
      }
    }
  }
  return 'µg';
}

(String, String) _bestDoseUnit(
    num perMin, num perH, num perMinMg, num perHMg, String massUnit) {
  // Use mg units when values are >= 1 in mg, otherwise stay in µg
  if (massUnit == 'mg') {
    if (perHMg >= 0.01) return (_fmt(perHMg), 'mg/kg/h');
    return (_fmt(perMinMg), 'mg/kg/min');
  }
  if (massUnit == 'IU') {
    if (perH >= 0.1) return (_fmt(perH), 'IU/kg/h');
    return (_fmt(perMin), 'IU/kg/min');
  }
  // µg (default)
  if (perMin >= 0.1) return (_fmt(perMin), 'µg/kg/min');
  if (perH >= 0.1) return (_fmt(perH), 'µg/kg/h');
  // Very small: show in ng
  return (_fmt(perMin * 1000.0), 'ng/kg/min');
}

String _formatEquivalents(
    num perMin, num perH, num perMinMg, num perHMg, String massUnit) {
  if (massUnit == 'IU') {
    return '${_fmt(perMin)} IU/kg/min  ·  ${_fmt(perH)} IU/kg/h';
  }
  return '${_fmt(perMin)} µg/kg/min  ·  ${_fmt(perH)} µg/kg/h  ·  '
      '${_fmt(perMinMg)} mg/kg/min  ·  ${_fmt(perHMg)} mg/kg/h';
}

String _fmt(num v) {
  if (v == 0) return '0';
  final abs = v.abs();
  if (abs >= 1000) return v.toStringAsFixed(0);
  if (abs >= 100) return v.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');
  if (abs >= 10) return v.toStringAsFixed(2).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  if (abs >= 1) return v.toStringAsFixed(3).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  if (abs >= 0.01) return v.toStringAsFixed(4).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  return v.toStringAsExponential(2);
}

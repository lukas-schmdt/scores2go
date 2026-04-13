# Multiple Organ Dysfunction Score (MODS)

The MODS quantifies the degree of organ dysfunction in critically ill patients across six organ systems. It was developed to provide a reproducible, objective measure of organ failure severity for use in ICU outcome research and clinical monitoring.

## Scoring System

Each organ system is scored 0–4. The total ranges from **0 to 24**.

### Respiratory — PaO₂ / FiO₂ Ratio (mmHg)

| Score | P/F Ratio |
|-------|-----------|
| 0 | > 300 |
| 1 | 226–300 |
| 2 | 151–225 |
| 3 | 76–150 |
| 4 | ≤ 75 |

### Renal — Serum Creatinine

| Score | µmol/L | mg/dL |
|-------|--------|-------|
| 0 | ≤ 100 | ≤ 1.1 |
| 1 | 101–200 | 1.2–2.3 |
| 2 | 201–350 | 2.4–3.9 |
| 3 | 351–500 | 4.0–5.7 |
| 4 | > 500 | > 5.7 |

Score without accounting for renal replacement therapy.

### Hepatic — Serum Bilirubin

| Score | µmol/L | mg/dL |
|-------|--------|-------|
| 0 | ≤ 20 | ≤ 1.2 |
| 1 | 21–60 | 1.3–3.5 |
| 2 | 61–120 | 3.6–7.0 |
| 3 | 121–240 | 7.1–14.0 |
| 4 | > 240 | > 14.0 |

### Cardiovascular — Pressure-Adjusted Heart Rate (PAR)

```text
PAR = Heart Rate × CVP / MAP
```

| Score | PAR |
|-------|-----|
| 0 | ≤ 10 |
| 1 | 10.1–15 |
| 2 | 15.1–20 |
| 3 | 20.1–30 |
| 4 | > 30 |

CVP = central venous pressure (right atrial pressure), MAP = mean arterial pressure, both in mmHg.

### Hematologic — Platelet Count (×10³/µL)

| Score | Platelets |
|-------|-----------|
| 0 | > 120 |
| 1 | 81–120 |
| 2 | 51–80 |
| 3 | 21–50 |
| 4 | ≤ 20 |

### Neurologic — Glasgow Coma Scale (GCS)

| Score | GCS |
|-------|-----|
| 0 | 15 |
| 1 | 13–14 |
| 2 | 10–12 |
| 3 | 7–9 |
| 4 | ≤ 6 |

Score the GCS directly, without correcting for sedation.

## Total Score Interpretation

| MODS Total | Severity | Predicted Mortality |
|------------|----------|---------------------|
| 0 | No dysfunction | ~0 % |
| 1–4 | Mild | ~1–7 % |
| 5–8 | Moderate | ~3–17 % |
| 9–12 | Severe | ~9–35 % |
| 13–16 | Very severe | ~24–69 % |
| > 16 | Maximum | ~49–100 % |

## Clinical Notes

- MODS is designed for **daily scoring** — track trends over the ICU stay.
- Unlike SOFA, MODS does not include a coagulation component and uses PAR rather than vasopressor dose for cardiovascular scoring.
- The cardiovascular PAR component requires a CVP measurement; if a central venous line is not in place, this component cannot be reliably scored.
- Sedation confounds the neurologic component; document accordingly.

## Reference

Marshall JC, Cook DJ, Christou NV, et al. *Multiple organ dysfunction score: a reliable descriptor of a complex clinical outcome.* Crit Care Med. 1995;23(10):1638–1652. [DOI: 10.1097/00003246-199510000-00007](https://doi.org/10.1097/00003246-199510000-00007)

const String demoDoc = '''
# Demo Score

## Overview

The **Demo Score** is a fictional clinical scoring tool used to showcase all supported
markdown features in this app. It is *not* intended for clinical use.

---

## Formula

Addition of selected points across three categories:

1. **Vitals** --- O₂ therapy, temperature, alertness
2. **Respiratory** --- ventilation status, FiO₂
3. **Risk factors** --- comorbidities, blood sugar

> The worst value within the first 24 hours should be used.
> Data should always be interpreted in clinical context.

---

## Point Values

### Vitals

| Variable | Criteria | Points |
|----------|----------|--------|
| O₂ Therapy | Yes | +2 |
| O₂ Therapy | No | 0 |
| Alertness | Alert | 0 |
| Alertness | Responds to voice | +1 |
| Alertness | Unresponsive | +2 |

### Respiratory

| FiO₂ | Points |
|------|--------|
| 21 % (room air) | 0 |
| 40 % | +1 |
| 60 % | +2 |
| ≥ 80 % | +3 |

### Risk Factors

| Comorbidity | Points |
|-------------|--------|
| Diabetes | +1 |
| COPD | +1 |
| Chronic kidney disease | +1 |
| Immunosuppression | +2 |

| Blood Sugar | Points |
|-------------|--------|
| < 60 mg/dL | +2 |
| 60--89 mg/dL | +1 |
| 90--110 mg/dL | 0 |
| > 110 mg/dL | +1 |

---

## Interpretation

Result
: Sum of all selected point values.

Risk
: Higher scores indicate greater clinical severity.

---

## Admonitions

:::note
This score is for demonstration purposes only. It has __no__ clinical validation.
:::

:::tip Use the progress bar
Tap any segment in the progress bar at the top to jump directly to that variable.
:::

:::info Unit switching
Some variables support multiple units (e.g. temperature in °C or °F, blood sugar
in mg/dL or mmol/L). Tap the unit chip next to the input to switch.
:::

:::warning Incomplete data
A score calculated with missing fields may not reflect the true clinical picture.
Skipped fields are highlighted in the progress bar.
:::

:::danger Not for clinical use
Do __not__ use this score for real patient management decisions.
:::

---

## Inline Formatting

Normal text with **bold**, *italic*, __underlined__, and `monospace` inline styles.
Use `---` for an em dash --- like this. Use `--` for ranges like 10--20.
Three dots become an ellipsis...

---

## Lists

Unordered list:

- First item
- Second item with **bold text**
- Third item
  - Nested item A
  - Nested item B

Ordered list:

1. Collect all variable values
2. Sum the points
3. Interpret the result

---

## Block Quote

> "All models are wrong, but some are useful."
>
> --- George Box

---

## Code

Inline: `score = vitals + respiratory + riskFactors`

Block:

```
if (o2Therapy == true) score += 2;
if (alertness == 'voice') score += 1;
if (alertness == 'unresponsive') score += 2;
```

---

## Links

Source code available on [GitHub](https://github.com/lukas-schmdt/scores2go).

---

## Footnotes

The scoring logic was inspired by established severity indices.[^1]
Temperature correction for unit conversion follows standard formulae.[^2]

[^1]: Knaus WA et al. APACHE II. Crit Care Med. 1985.
[^2]: °F = °C × 9/5 + 32
''';

# Dose Calculator

A two-way infusion calculator for weight-adjusted drug dosing. Converts between pump rate (ml/h) and dose per kg and time unit.

## Modes

| Mode | Input | Output |
|------|-------|--------|
| **Dose → Rate** | Target dose (e.g. 0.1 µg/kg/min) | Pump rate (ml/h) |
| **Rate → Dose** | Current pump rate (ml/h) | Dose per kg |

## Formula

```
Rate (ml/h) = Dose (µg/kg/min) × Weight (kg) × 60
              ──────────────────────────────────────
                  Concentration (µg/ml)
```

where **Concentration (µg/ml) = Drug amount / Total volume**.

## Supported Units

**Drug amount / dose:**

| Unit | Notes |
|------|-------|
| µg | Microgram — default for catecholamines |
| mg | Milligram — common for sedatives, analgesics |
| IU | International Units — heparin, insulin, vasopressin |

**Dose time unit** (tap the chip on the dose field to cycle):

| Unit | Typical use |
|------|-------------|
| /min | Catecholamines (norepinephrine, dopamine, dobutamine) |
| /h | Sedatives, analgesics, heparin, insulin |

:::info Unit consistency
The mass unit of the **drug amount** and the **target dose** must refer to the same substance quantity. If you enter the concentration in mg, use mg/kg/h for the dose — not µg/kg/min.

Practical tip: enter the concentration in the same unit printed on the drug label, then select the matching dose unit.
:::

## Common Examples

### Norepinephrine 4 mg in 50 ml → 0.1 µg/kg/min in 75 kg

- Drug amount: **4 mg** (= 4000 µg)
- Total volume: **50 ml**
- Concentration: 4000 / 50 = **80 µg/ml**
- Rate = 0.1 × 75 × 60 / 80 = **5.6 ml/h**

### Heparin 25 000 IU in 50 ml → 15 IU/kg/h in 80 kg

- Drug amount: **25 000 IU**
- Total volume: **50 ml**
- Concentration: 25 000 / 50 = **500 IU/ml**
- Rate = 15 × 80 / (500 × 60 / 60) = 15 × 80 / 500 = **2.4 ml/h**

## Tips

- The **total volume** defaults to 50 ml (standard syringe pump volume).
- Tap the **unit chip** (top-right of each number field) to cycle through available units.
- In **Rate → Dose** mode, the result shows the dose in the most readable unit plus all common equivalents.

# SAPS 3 — Simplified Acute Physiology Score 3

SAPS 3 predicts in-hospital mortality using 20 variables collected at ICU admission. It was developed to supersede SAPS II with better calibration across different case-mix populations and geographic regions.

## Three-Box Structure

The score is divided into three boxes representing different domains:

### Box I — Patient Information (before ICU admission)

| Variable | Range | Points |
|----------|-------|--------|
| Age | < 40 yr | 0 |
| | 40–59 yr | 5 |
| | 60–69 yr | 9 |
| | 70–74 yr | 13 |
| | 75–79 yr | 15 |
| | ≥ 80 yr | 18 |
| Chronic comorbidities | CHF NYHA IV | +6 |
| | Liver cirrhosis | +4 |
| | Chronic alcohol abuse | +3 |
| | Active neoplasm | +6 |
| | Haematological malignancy | +6 |
| | Metastatic cancer | +9 |
| | AIDS | +8 |
| Mechanical ventilation | Yes | +9 |

### Box II — Admission Circumstances

| Variable | Option | Points |
|----------|--------|--------|
| Pre-ICU location | Recovery room | −6 |
| | Emergency room | 0 |
| | Other hospital | 0 |
| | Ward | +6 |
| | Direct admission | 0 |
| Surgical admission | Scheduled (elective) | −6 |
| Reason for ICU | Medical / other | 0 |
| | Sepsis / septic shock | +5 |
| | Acute respiratory failure | +4 |
| | Cardiac arrest before ICU | +10 |
| | Cardiac rhythm disturbance | +5 |
| | Trauma | −8 |
| | Drug intoxication | −13 |
| | Intracranial mass effect | +7 |
| | Metabolic / renal / hepatic failure | +5 |
| | GI perforation / obstruction | +5 |
| | Elective post-operative | −6 |

### Box III — Acute Physiology (worst values within 1 h of ICU admission)

| Variable | Range | Points |
|----------|-------|--------|
| GCS | 15 | 0 |
| | 13–14 | 4 |
| | 10–12 | 7 |
| | 7–9 | 10 |
| | 3–6 | 15 |
| Bilirubin | < 2 mg/dL | 0 |
| | 2–5.9 | 4 |
| | 6–8.9 | 5 |
| | ≥ 9 | 6 |
| Temperature | < 35 °C | 4 |
| | 35–39.9 °C | 0 |
| | ≥ 40 °C | 3 |
| Heart rate | < 40 bpm | 11 |
| | 40–59 | 2 |
| | 60–119 | 0 |
| | 120–159 | 4 |
| | ≥ 160 | 7 |
| MAP | < 40 mmHg | 18 |
| | 40–69 | 7 |
| | 70–119 | 0 |
| | ≥ 120 | 3 |
| Creatinine | < 1.2 mg/dL | 0 |
| | 1.2–1.99 | 2 |
| | 2.0–3.49 | 7 |
| | ≥ 3.5 | 8 |
| Platelets | < 20 ×10³/µL | 13 |
| | 20–49 | 8 |
| | 50–99 | 5 |
| | 100–149 | 3 |
| | ≥ 150 | 0 |
| WBC | < 1 ×10³/µL | 12 |
| | 1–14.9 | 0 |
| | ≥ 15 | 3 |
| Arterial pH | < 7.00 | 14 |
| | 7.00–7.24 | 11 |
| | 7.25–7.32 | 6 |
| | 7.33–7.49 | 0 |
| | ≥ 7.50 | 3 |
| PaO₂/FiO₂ | < 100 (ventilated) | 11 |
| | 100–199 | 9 |
| | ≥ 200 | 5 |

:::info PaO₂/FiO₂
PaO₂/FiO₂ is only scored when the patient is **mechanically ventilated**. If not ventilated, this field is skipped.
:::

## Mortality Prediction

The SAPS 3 score is converted to predicted hospital mortality using the **global equation**:

```
logit = −36.0757 + ln(SAPS3 + 20.5958) × 7.3068
predicted mortality = eˡᵒᵍⁱᵗ / (1 + eˡᵒᵍⁱᵗ)
```

:::note Regional Equations
Regional customisation equations exist for Central/Western Europe, Eastern Europe, Australasia, North America, Latin America, and Africa. The global equation is used by default.
:::

## Risk Classification

| Predicted Mortality | Risk Class |
|---------------------|------------|
| < 10 % | Low risk |
| 10–24 % | Moderate risk |
| 25–49 % | High risk |
| ≥ 50 % | Very high risk |

## Facts & Figures

- Validated in 19,577 patients from 303 ICUs in 35 countries (2002–2003)
- AUC: 0.848 (global equation)
- Better calibration than APACHE II and SAPS II across international populations
- Developed as part of the SAPS 3 Outcomes Research Group

## Literature

- Moreno RP, et al. *SAPS 3 — From evaluation of the patient to evaluation of the intensive care unit.* Intensive Care Med. 2005;31(10):1336–1344.
- Metnitz PG, et al. *SAPS 3 — From evaluation of the patient to evaluation of the intensive care unit.* Intensive Care Med. 2005;31(10):1345–1355.

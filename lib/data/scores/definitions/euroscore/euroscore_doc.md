# EuroSCORE II

EuroSCORE II (European System for Cardiac Operative Risk Evaluation II) is the current standard for preoperative risk stratification in adult cardiac surgery. It estimates 30-day operative mortality using logistic regression on 18 clinical variables.

## Background

EuroSCORE II replaced the original additive and logistic EuroSCORE models, which had become miscalibrated due to improvements in cardiac surgical outcomes since their development in 1999. The updated model was derived from a large prospective European dataset (2010–2011).

:::info Model Type
EuroSCORE II uses **logistic regression** — it predicts a continuous probability of 30-day mortality, not a simple risk category.
:::

## Formula

```
logit = −5.324537 + Σ(coefficient × variable value)
predicted mortality = eˡᵒᵍⁱᵗ / (1 + eˡᵒᵍⁱᵗ)
```

## Variables and Coefficients

### Patient Factors

| Variable | Coefficient |
|----------|-------------|
| Age (per year) | 0.0285181 |
| Female sex | 0.2196434 |
| Serum creatinine > 200 µmol/L | 0.6521653 |
| Extracardiac arteriopathy | 0.5360268 |
| Poor mobility | 0.2407651 |
| Previous cardiac surgery | 1.118599 |
| Chronic lung disease | 0.1886564 |
| Active endocarditis | 0.6194522 |
| Critical preoperative state | 1.086517 |
| Diabetes on insulin | 0.3542749 |

### NYHA Class

| Class | Coefficient |
|-------|-------------|
| I | 0.0 |
| II | 0.1082900 |
| III | 0.2962689 |
| IV | 0.5462446 |

### CCS Class 4 Angina

| Status | Coefficient |
|--------|-------------|
| No | 0.0 |
| Yes | 0.2226147 |

### Cardiac Factors

| Variable | Option | Coefficient |
|----------|--------|-------------|
| LV function (EF) | Good (> 50 %) | 0.0 |
| | Moderate (31–50 %) | 0.3150652 |
| | Poor (21–30 %) | 0.8084096 |
| | Very poor (≤ 20 %) | 0.9346919 |
| Recent MI (< 90 days) | Yes | 0.1528943 |
| Pulmonary hypertension | None | 0.0 |
| | Moderate (31–55 mmHg) | 0.1788899 |
| | Severe (> 55 mmHg) | 0.3491475 |

### Operation Factors

| Variable | Option | Coefficient |
|----------|--------|-------------|
| Urgency | Elective | 0.0 |
| | Urgent | 0.3174673 |
| | Emergency | 0.7039121 |
| | Salvage | 1.3337492 |
| Weight of procedure | Isolated CABG | 0.0 |
| | Single non-CABG | 0.0062118 |
| | 2 cardiac procedures | 0.5521478 |
| | ≥ 3 cardiac procedures | 0.9724533 |
| Surgery on thoracic aorta | Yes | 0.6527205 |
| Post-infarct septal rupture | Yes | 1.462009 |

## Risk Classification

| Predicted Mortality | Risk Class |
|---------------------|------------|
| < 2 % | Low risk |
| 2–4.9 % | Moderate risk |
| 5–9.9 % | High risk |
| ≥ 10 % | Very high risk |

:::warning Interpretation
EuroSCORE II **overestimates mortality in high-risk patients** when applied to contemporary cohorts, partly because outcomes have continued to improve since the 2010–2011 derivation dataset. Use EuroSCORE II as one input among many for shared decision-making.
:::

## Facts & Figures

- Derivation dataset: 22,381 patients across 154 hospitals in 43 countries (2010–2011)
- AUC: 0.8095
- Observed overall mortality in derivation cohort: 3.93 %
- EuroSCORE II predicted overall mortality: 3.95 %

## Literature

- Nashef SA, et al. *EuroSCORE II.* Eur J Cardiothorac Surg. 2012;41(4):734–745.
- Kirmani BH, et al. *Logistic or additive EuroSCORE for high-risk cardiac surgical patients?* Interact Cardiovasc Thorac Surg. 2013;16(3):281–287.

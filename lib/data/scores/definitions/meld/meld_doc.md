# Model for End-Stage Liver Disease (MELD)

The MELD score is an objective, laboratory-based tool for assessing short-term prognosis in patients with end-stage liver disease. It was originally developed to predict 90-day survival after TIPS placement and has since become the primary organ allocation algorithm for liver transplantation in the United States and Europe.

## Formula

$$\text{MELD} = 3.78 \cdot \ln(\text{Bilirubin}) + 11.2 \cdot \ln(\text{INR}) + 9.57 \cdot \ln(\text{Creatinine}) + 6.43$$

All values are in **mg/dL**. The result is rounded to the nearest integer and clamped to the range **6–40**.

## Clamping Rules

| Variable | Floor | Cap | Special |
|----------|-------|-----|---------|
| Bilirubin | 1.0 mg/dL | — | — |
| INR | 1.0 | — | — |
| Creatinine | 1.0 mg/dL | 4.0 mg/dL | Dialysis ≥ 2×/week → set to 4.0 mg/dL |

## Score Interpretation

| MELD Score | Severity | Approx. 90-day Mortality |
|------------|----------|--------------------------|
| < 10 | Low | < 2 % |
| 10–19 | Moderate | ~6 % |
| 20–29 | High | ~20 % |
| 30–39 | Very high | ~52 % |
| ≥ 40 | Extreme | > 71 % |

## Clinical Use

- **Transplant listing priority**: Higher MELD = higher urgency on the waiting list.
- **ICU / hepatology**: Guides intensity of care and treatment escalation decisions.
- **Post-TIPS**: Predicts hepatic encephalopathy and survival following shunt placement.
- **Spontaneous bacterial peritonitis (SBP)**: MELD ≥ 20 at SBP diagnosis indicates high short-term mortality.

## Notes

- MELD does **not** account for complications such as hepatic encephalopathy, refractory ascites, or hepatopulmonary syndrome — these are addressed by exception points in transplant systems.
- **MELD-Na** extends the original score by adding serum sodium, improving prediction accuracy for patients with hyponatraemia.
- Serial MELD measurements (trend) are more informative than a single value.

## Reference

Kamath PS, Wiesner RH, Malinchoc M, et al. *A model to predict survival in patients with end-stage liver disease.* Hepatology. 2001;33(2):464–470. [DOI: 10.1053/jhep.2001.22172](https://doi.org/10.1053/jhep.2001.22172)

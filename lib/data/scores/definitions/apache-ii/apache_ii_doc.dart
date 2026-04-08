const String apacheIiDoc = '''
# APACHE II Score

## Formula

Addition of the selected points; points assigned below.

## Facts & Figures

The APACHE-II Score provides an estimate of ICU mortality based on a number of laboratory values and patient signs taking both acute and chronic disease into account.

**Note:** The data used should be from the initial 24 hours in the ICU, and the worst value (further from baseline/normal) should be used.

The following defines "chronic organ insufficiency" and immunocompromise:

**Liver insufficiency**

- Biopsy proven cirrhosis
- Documented portal hypertension
- Episodes of past upper GI bleeding attributed to portal hypertension
- Prior episodes of hepatic failure

**Cardiovascular**

- New York Heart Association Class IV Heart Failure

**Respiratory**

- Chronic restrictive, or vascular disease resulting in severe exercise restriction, i.e. unable to climb stairs or perform household duties
- Documented chronic hypoxia, hypercapnia, secondary severe pulmonary hypertension (>40 mmHg), or respirator dependency

**Renal**

- Receiving chronic dialysis

**Immunosuppression**

- The patient has received therapy that suppresses resistance to infection e.g. immuno-suppression, chemotherapy, radiation, or recent high dose steroids, or has a disease that is sufficiently advanced to suppress resistance to infection, e.g. leukemia, lymphoma, AIDS

## Point Values

### Age, years

| Range | Points |
|-------|--------|
| ≤44 | 0 |
| 45--54 | +2 |
| 55--64 | +3 |
| 65--74 | +5 |
| >74 | +6 |

### History of severe organ insufficiency or immunocompromised

| Criteria | Points |
|----------|--------|
| Yes, and nonoperative or emergency postoperative patient | +5 |
| Yes, and elective postoperative patient | +2 |
| No | 0 |

### Rectal temperature, °C

| Range | Points |
|-------|--------|
| ≥41 | +4 |
| 39 to <41 | +3 |
| 38.5 to <39 | +1 |
| 36 to <38.5 | 0 |
| 34 to <36 | +1 |
| 32 to <34 | +2 |
| 30 to <32 | +3 |
| <30 | +4 |

### Mean arterial pressure, mmHg

| Range | Points |
|-------|--------|
| >159 | +4 |
| >129--159 | +3 |
| >109--129 | +2 |
| >69--109 | 0 |
| >49--69 | +2 |
| ≤49 | +4 |

### Heart rate, beats per minute

| Range | Points |
|-------|--------|
| ≥180 | +4 |
| 140 to <180 | +3 |
| 110 to <140 | +2 |
| 70 to <110 | 0 |
| 55 to <70 | +2 |
| 40 to <55 | +3 |
| <40 | +4 |

### Respiratory rate, breaths per minute

| Range | Points |
|-------|--------|
| ≥50 | +4 |
| 35 to <50 | +3 |
| 25 to <35 | +1 |
| 12 to <25 | 0 |
| 10 to <12 | +1 |
| 6 to <10 | +2 |
| <6 | +4 |

### Oxygenation

Use PaO₂ if FiO₂ <50%, otherwise use A-a gradient.

| Criteria | Points |
|----------|--------|
| A-a gradient >499 | +4 |
| A-a gradient 350--499 | +3 |
| A-a gradient 200--349 | +2 |
| A-a gradient <200 (if FiO₂ >49%) or PaO₂ >70 (if FiO₂ <50%) | 0 |
| PaO₂ = 61--70 | +1 |
| PaO₂ = 55--60 | +3 |
| PaO₂ <55 | +4 |

### Arterial pH

| Range | Points |
|-------|--------|
| ≥7.70 | +4 |
| 7.60 to <7.70 | +3 |
| 7.50 to <7.60 | +1 |
| 7.33 to <7.50 | 0 |
| 7.25 to <7.33 | +2 |
| 7.15 to <7.25 | +3 |
| <7.15 | +4 |

### Serum sodium, mmol/L

| Range | Points |
|-------|--------|
| ≥180 | +4 |
| 160 to <180 | +3 |
| 155 to <160 | +2 |
| 150 to <155 | +1 |
| 130 to <150 | 0 |
| 120 to <130 | +2 |
| 111 to <120 | +3 |
| <111 | +4 |

### Serum potassium, mmol/L

| Range | Points |
|-------|--------|
| ≥7.0 | +4 |
| 6.0 to <7.0 | +3 |
| 5.5 to <6.0 | +1 |
| 3.5 to <5.5 | 0 |
| 3.0 to <3.5 | +1 |
| 2.5 to <3.0 | +2 |
| <2.5 | +4 |

### Serum creatinine, mg/100 mL

| Criteria | Points |
|----------|--------|
| ≥3.5 and ACUTE renal failure* | +8 |
| 2.0 to <3.5 and ACUTE renal failure | +6 |
| ≥3.5 and CHRONIC renal failure | +4 |
| 1.5 to <2.0 and ACUTE renal failure | +4 |
| 2.0 to <3.5 and CHRONIC renal failure | +3 |
| 1.5 to <2.0 and CHRONIC renal failure | +2 |
| 0.6 to <1.5 | 0 |
| <0.6 | +2 |

*"Acute renal failure" was not defined in the original study. Use clinical judgment to determine whether the patient has acute kidney injury.

### Hematocrit, %

| Range | Points |
|-------|--------|
| ≥60 | +4 |
| 50 to <60 | +2 |
| 46 to <50 | +1 |
| 30 to <46 | 0 |
| 20 to <30 | +2 |
| <20 | +4 |

### White blood count, total/cubic mm (×1000)

| Range | Points |
|-------|--------|
| ≥40 | +4 |
| 20 to <40 | +2 |
| 15 to <20 | +1 |
| 3 to <15 | 0 |
| 1 to <3 | +2 |
| <1 | +4 |

### Glasgow Coma Scale (GCS)

Points = 15 − [GCS Score]

## Approximated In-Hospital Mortality Rates

| APACHE II Score | Nonoperative | Postoperative |
|-----------------|-------------|---------------|
| 0--4 | 4% | 1% |
| 5--9 | 8% | 3% |
| 10--14 | 15% | 7% |
| 15--19 | 25% | 12% |
| 20--24 | 40% | 30% |
| 25--29 | 55% | 35% |
| 30--34 | 73% | 73% |
| >34 | 85% | 88% |

*From Knaus et al. 1985.*

## Evidence Appraisal

The APACHE II score was initially presented and validated by Knaus et al. in a study that prospectively enrolled 5815 patients from 13 hospitals. Complete data on all 12 physiologic measurements was available for 5030 patients. The APACHE II score was shown to have good prognostic value in acutely ill patients.

A subsequent study prospectively validated the APACHE II score in 1721 consecutively admitted patients in a single center. The area under the ROC curve was higher than 0.8. The patient population was mostly comprised of surgical patients.

## Literature

### Original Reference

Knaus WA, Draper EA, Wagner DP, Zimmerman JE. *APACHE II: a severity of disease classification system.* Crit Care Med. 1985 Oct;13(10):818--29.

### Validation

Headley J, Theriault R, Smith TL. *Independent validation of APACHE II severity of illness score for predicting mortality in patients with breast cancer admitted to the intensive care unit.* Cancer. 1992 Jul 15;70(2):497--503.

### Other References

Capuzzo M, Valpondi V, Sgarbi A, et al. *Validation of severity scoring systems SAPS II and APACHE II in a single-center population.* Intensive Care Med. 2000 Dec;26(12):1779--85.
''';

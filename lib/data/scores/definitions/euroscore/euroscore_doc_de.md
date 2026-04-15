# EuroSCORE II

EuroSCORE II (European System for Cardiac Operative Risk Evaluation II) ist der aktuelle Standard zur präoperativen Risikoabschätzung in der Erwachsenenkardiochirurgie. Er schätzt die 30-Tage-Operationsmortalität mithilfe einer logistischen Regression auf Basis von 18 klinischen Variablen.

## Hintergrund

EuroSCORE II ersetzte die ursprünglichen additiven und logistischen EuroSCORE-Modelle, die durch die verbesserten Ergebnisse der Herzchirurgie seit ihrer Entwicklung im Jahr 1999 fehlkalibriert geworden waren. Das aktualisierte Modell wurde aus einem großen prospektiven europäischen Datensatz (2010–2011) abgeleitet.

:::info Modelltyp
EuroSCORE II verwendet **logistische Regression** — er sagt eine kontinuierliche Wahrscheinlichkeit der 30-Tage-Mortalität voraus, keine einfache Risikokategorie.
:::

## Formel

```
logit = −5,324537 + Σ(Koeffizient × Variablenwert)
vorhergesagte Mortalität = eˡᵒᵍⁱᵗ / (1 + eˡᵒᵍⁱᵗ)
```

## Variablen und Koeffizienten

### Patientenfaktoren

| Variable | Koeffizient |
|----------|-------------|
| Alter (pro Jahr) | 0,0285181 |
| Weibliches Geschlecht | 0,2196434 |
| Serum-Kreatinin > 200 µmol/L | 0,6521653 |
| Extrakardiäre Arteriopathie | 0,5360268 |
| Eingeschränkte Mobilität | 0,2407651 |
| Vorherige Herzoperation | 1,118599 |
| Chronische Lungenerkrankung | 0,1886564 |
| Aktive Endokarditis | 0,6194522 |
| Kritischer präoperativer Zustand | 1,086517 |
| Insulinpflichtiger Diabetes | 0,3542749 |

### NYHA-Klasse

| Klasse | Koeffizient |
|--------|-------------|
| I | 0,0 |
| II | 0,1082900 |
| III | 0,2962689 |
| IV | 0,5462446 |

### CCS-Klasse-4-Angina

| Status | Koeffizient |
|--------|-------------|
| Nein | 0,0 |
| Ja | 0,2226147 |

### Kardiologische Faktoren

| Variable | Option | Koeffizient |
|----------|--------|-------------|
| LV-Funktion (EF) | Gut (> 50 %) | 0,0 |
| | Mäßig (31–50 %) | 0,3150652 |
| | Schlecht (21–30 %) | 0,8084096 |
| | Sehr schlecht (≤ 20 %) | 0,9346919 |
| Kürzlicher Herzinfarkt (< 90 Tage) | Ja | 0,1528943 |
| Pulmonale Hypertonie | Keine | 0,0 |
| | Mäßig (31–55 mmHg) | 0,1788899 |
| | Schwer (> 55 mmHg) | 0,3491475 |

### Operationsfaktoren

| Variable | Option | Koeffizient |
|----------|--------|-------------|
| Dringlichkeit | Elektiv | 0,0 |
| | Dringend | 0,3174673 |
| | Notfall | 0,7039121 |
| | Salvage | 1,3337492 |
| Eingriffskomplexität | Isolierter ACVB | 0,0 |
| | Einzelner Nicht-ACVB | 0,0062118 |
| | 2 Herzeingriffe | 0,5521478 |
| | ≥ 3 Herzeingriffe | 0,9724533 |
| Operation an der thorakalen Aorta | Ja | 0,6527205 |
| Postinfarkt-Ventrikelseptumruptur | Ja | 1,462009 |

## Risikoklassifikation

| Vorhergesagte Mortalität | Risikoklasse |
|--------------------------|--------------|
| < 2 % | Niedriges Risiko |
| 2–4,9 % | Mittleres Risiko |
| 5–9,9 % | Hohes Risiko |
| ≥ 10 % | Sehr hohes Risiko |

:::warning Interpretation
EuroSCORE II **überschätzt die Mortalität bei Hochrisikopatienten**, wenn er auf zeitgenössische Kohorten angewendet wird, teilweise weil sich die Ergebnisse seit dem Ableitungsdatensatz von 2010–2011 weiter verbessert haben. EuroSCORE II sollte als einer von mehreren Faktoren in der gemeinsamen Entscheidungsfindung genutzt werden.
:::

## Fakten & Zahlen

- Ableitungsdatensatz: 22.381 Patienten aus 154 Krankenhäusern in 43 Ländern (2010–2011)
- AUC: 0,8095
- Beobachtete Gesamtmortalität im Ableitungskollektiv: 3,93 %
- EuroSCORE-II-vorhergesagte Gesamtmortalität: 3,95 %

## Literatur

- Nashef SA, et al. *EuroSCORE II.* Eur J Cardiothorac Surg. 2012;41(4):734–745.
- Kirmani BH, et al. *Logistic or additive EuroSCORE for high-risk cardiac surgical patients?* Interact Cardiovasc Thorac Surg. 2013;16(3):281–287.

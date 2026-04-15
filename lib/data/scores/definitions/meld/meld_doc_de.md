# Model for End-Stage Liver Disease (MELD)

Der MELD-Score ist ein objektives, laborbasiertes Instrument zur Beurteilung der Kurzzeit-Prognose bei Patienten mit Lebererkrankung im Endstadium. Er wurde ursprünglich entwickelt, um das 90-Tage-Überleben nach TIPSS-Anlage vorherzusagen, und ist inzwischen der primäre Organallokationsalgorithmus für die Lebertransplantation in den USA und Europa.

## Formel

```text
MELD = 3,78 × ln(Bilirubin) + 11,2 × ln(INR) + 9,57 × ln(Kreatinin) + 6,43
```

Alle Werte in **mg/dL**. Das Ergebnis wird auf die nächste ganze Zahl gerundet und auf den Bereich **6–40** begrenzt.

## Begrenzungsregeln

| Variable | Untergrenze | Obergrenze | Besonderheit |
|----------|-------------|------------|--------------|
| Bilirubin | 1,0 mg/dL | — | — |
| INR | 1,0 | — | — |
| Kreatinin | 1,0 mg/dL | 4,0 mg/dL | Dialyse ≥ 2×/Woche → Wert auf 4,0 mg/dL setzen |

## Score-Interpretation

| MELD-Score | Schweregrad | Ca. 90-Tage-Mortalität |
|------------|-------------|------------------------|
| < 10 | Niedrig | < 2 % |
| 10–19 | Mäßig | ~6 % |
| 20–29 | Hoch | ~20 % |
| 30–39 | Sehr hoch | ~52 % |
| ≥ 40 | Extrem | > 71 % |

## Klinische Anwendung

- **Transplantationspriorität:** Höherer MELD = höhere Dringlichkeit auf der Warteliste.
- **ITS / Hepatologie:** Orientierung für die Intensität der Versorgung und Therapieeskalation.
- **Post-TIPSS:** Vorhersage von hepatischer Enzephalopathie und Überleben nach Shunt-Anlage.
- **Spontane bakterielle Peritonitis (SBP):** MELD ≥ 20 bei SBP-Diagnose zeigt hohe Kurzzeitmortalität an.

## Hinweise

- MELD berücksichtigt **keine** Komplikationen wie hepatische Enzephalopathie, refraktären Aszites oder hepatopulmonales Syndrom — diese werden in Transplantationssystemen durch Ausnahmepunkte abgebildet.
- **MELD-Na** erweitert den ursprünglichen Score um das Serum-Natrium und verbessert die Vorhersagegenauigkeit bei Patienten mit Hyponatriämie.
- Serielle MELD-Messungen (Verlauf) sind aussagekräftiger als ein Einzelwert.

## Literatur

Kamath PS, Wiesner RH, Malinchoc M, et al. *A model to predict survival in patients with end-stage liver disease.* Hepatology. 2001;33(2):464–470. [DOI: 10.1053/jhep.2001.22172](https://doi.org/10.1053/jhep.2001.22172)

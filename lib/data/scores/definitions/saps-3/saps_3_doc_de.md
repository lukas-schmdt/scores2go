# SAPS 3 — Simplified Acute Physiology Score 3

SAPS 3 sagt die Krankenhausmortalität anhand von 20 Variablen vorher, die bei ITS-Aufnahme erhoben werden. Er wurde entwickelt, um SAPS II mit besserer Kalibrierung für unterschiedliche Patientenpopulationen und geografische Regionen abzulösen.

## Drei-Boxen-Struktur

Der Score gliedert sich in drei Bereiche, die verschiedene Domänen abbilden:

### Box I — Patienteninformationen (vor ITS-Aufnahme)

| Variable | Bereich | Punkte |
|----------|---------|--------|
| Alter | < 40 Jahre | 0 |
| | 40–59 Jahre | 5 |
| | 60–69 Jahre | 9 |
| | 70–74 Jahre | 13 |
| | 75–79 Jahre | 15 |
| | ≥ 80 Jahre | 18 |
| Chronische Komorbiditäten | Herzinsuffizienz NYHA IV | +6 |
| | Leberzirrhose | +4 |
| | Chronischer Alkoholmissbrauch | +3 |
| | Aktive Neoplasie | +6 |
| | Hämatologische Malignität | +6 |
| | Metastasiertes Karzinom | +9 |
| | AIDS | +8 |
| Maschinelle Beatmung | Ja | +9 |

### Box II — Aufnahmeumstände

| Variable | Option | Punkte |
|----------|--------|--------|
| Prä-ITS-Aufenthaltsort | Aufwachraum | −6 |
| | Notaufnahme | 0 |
| | Anderes Krankenhaus | 0 |
| | Normalstation | +6 |
| | Direktaufnahme | 0 |
| Chirurgische Aufnahme | Geplant (elektiv) | −6 |
| Aufnahmegrund | Medizinisch / sonstige | 0 |
| | Sepsis / septischer Schock | +5 |
| | Akutes Atemversagen | +4 |
| | Herzstillstand vor ITS | +10 |
| | Herzrhythmusstörung | +5 |
| | Trauma | −8 |
| | Medikamentenvergiftung | −13 |
| | Intrakranielle Raumforderung | +7 |
| | Metabolisches / renales / hepatisches Versagen | +5 |
| | Elektiv postoperativ | −6 |

### Box III — Akute Physiologie (schlechteste Werte innerhalb 1 h nach ITS-Aufnahme)

| Variable | Bereich | Punkte |
|----------|---------|--------|
| GCS | 15 | 0 |
| | 13–14 | 4 |
| | 10–12 | 7 |
| | 7–9 | 10 |
| | 3–6 | 15 |
| Bilirubin | < 2 mg/dL | 0 |
| | 2–5,9 | 4 |
| | 6–8,9 | 5 |
| | ≥ 9 | 6 |
| Temperatur | < 35 °C | 4 |
| | 35–39,9 °C | 0 |
| | ≥ 40 °C | 3 |
| Herzfrequenz | < 40 /min | 11 |
| | 40–59 | 2 |
| | 60–119 | 0 |
| | 120–159 | 4 |
| | ≥ 160 | 7 |
| MAP | < 40 mmHg | 18 |
| | 40–69 | 7 |
| | 70–119 | 0 |
| | ≥ 120 | 3 |
| Kreatinin | < 1,2 mg/dL | 0 |
| | 1,2–1,99 | 2 |
| | 2,0–3,49 | 7 |
| | ≥ 3,5 | 8 |
| Thrombozyten | < 20 ×10³/µL | 13 |
| | 20–49 | 8 |
| | 50–99 | 5 |
| | 100–149 | 3 |
| | ≥ 150 | 0 |
| Leukozyten | < 1 ×10³/µL | 12 |
| | 1–14,9 | 0 |
| | ≥ 15 | 3 |
| Arterieller pH | < 7,00 | 14 |
| | 7,00–7,24 | 11 |
| | 7,25–7,32 | 6 |
| | 7,33–7,49 | 0 |
| | ≥ 7,50 | 3 |
| PaO₂/FiO₂ | < 100 (beatmet) | 11 |
| | 100–199 | 9 |
| | ≥ 200 | 5 |

:::info PaO₂/FiO₂
PaO₂/FiO₂ wird nur bewertet, wenn der Patient **maschinell beatmet** ist. Ohne Beatmung wird dieses Feld übersprungen.
:::

## Mortalitätsvorhersage

Der SAPS-3-Score wird mithilfe der **globalen Gleichung** in die vorhergesagte Krankenhausmortalität umgerechnet:

```
logit = −36,0757 + ln(SAPS3 + 20,5958) × 7,3068
vorhergesagte Mortalität = eˡᵒᵍⁱᵗ / (1 + eˡᵒᵍⁱᵗ)
```

:::note Regionale Gleichungen
Regionale Anpassungsgleichungen existieren für Mittel-/Westeuropa, Osteuropa, Australasien, Nordamerika, Lateinamerika und Afrika. Standardmäßig wird die globale Gleichung verwendet.
:::

## Risikoklassifikation

| Vorhergesagte Mortalität | Risikoklasse |
|--------------------------|--------------|
| < 10 % | Niedriges Risiko |
| 10–24 % | Mäßiges Risiko |
| 25–49 % | Hohes Risiko |
| ≥ 50 % | Sehr hohes Risiko |

## Fakten & Zahlen

- Validiert an 19.577 Patienten aus 303 ITS in 35 Ländern (2002–2003)
- AUC: 0,848 (globale Gleichung)
- Bessere Kalibrierung als APACHE II und SAPS II bei internationalen Patientenpopulationen
- Entwickelt im Rahmen der SAPS-3-Outcomes-Research-Gruppe

## Literatur

- Moreno RP, et al. *SAPS 3 — From evaluation of the patient to evaluation of the intensive care unit.* Intensive Care Med. 2005;31(10):1336–1344.
- Metnitz PG, et al. *SAPS 3 — From evaluation of the patient to evaluation of the intensive care unit.* Intensive Care Med. 2005;31(10):1345–1355.

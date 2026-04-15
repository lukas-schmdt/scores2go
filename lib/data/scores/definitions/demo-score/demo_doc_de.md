# Demo Score

## Übersicht

Der **Demo Score** ist ein fiktives klinisches Scoring-Instrument, das alle unterstützten
Markdown-Funktionen dieser App demonstriert. Er ist *nicht* für den klinischen Einsatz bestimmt.

---

## Formel

Addition der ausgewählten Punkte aus drei Kategorien:

1. **Vitalzeichen** --- O₂-Therapie, Temperatur, Bewusstseinszustand
2. **Respiratorisch** --- Beatmungsstatus, FiO₂
3. **Risikofaktoren** --- Komorbiditäten, Blutzucker

> Der schlechteste Wert innerhalb der ersten 24 Stunden sollte verwendet werden.
> Daten sollten stets im klinischen Kontext interpretiert werden.

---

## Punktwerte

### Vitalzeichen

| Variable | Kriterien | Punkte |
|----------|-----------|--------|
| O₂-Therapie | Ja | +2 |
| O₂-Therapie | Nein | 0 |
| Bewusstsein | Wach | 0 |
| Bewusstsein | Reagiert auf Ansprache | +1 |
| Bewusstsein | Keine Reaktion | +2 |

### Respiratorisch

| FiO₂ | Punkte |
|------|--------|
| 21 % (Raumluft) | 0 |
| 40 % | +1 |
| 60 % | +2 |
| ≥ 80 % | +3 |

### Risikofaktoren

| Komorbidität | Punkte |
|--------------|--------|
| Diabetes mellitus | +1 |
| COPD | +1 |
| Chronische Nierenerkrankung | +1 |
| Immunsuppression | +2 |

| Blutzucker | Punkte |
|------------|--------|
| < 60 mg/dL | +2 |
| 60–89 mg/dL | +1 |
| 90–110 mg/dL | 0 |
| > 110 mg/dL | +1 |

---

## Interpretation

Ergebnis
: Summe aller ausgewählten Punktwerte.

Risiko
: Höhere Werte weisen auf einen schwereren klinischen Zustand hin.

---

## Hinweise

:::note
Dieser Score dient ausschließlich Demonstrationszwecken. Er besitzt __keine__ klinische Validierung.
:::

:::tip Fortschrittsbalken nutzen
Tippen Sie auf ein Segment im Fortschrittsbalken oben, um direkt zu der entsprechenden Variable zu springen.
:::

:::info Einheitenwechsel
Einige Variablen unterstützen mehrere Einheiten (z. B. Temperatur in °C oder °F, Blutzucker
in mg/dL oder mmol/L). Tippen Sie auf den Einheiten-Chip neben dem Eingabefeld, um die Einheit zu wechseln.
:::

:::warning Unvollständige Daten
Ein Score, der mit fehlenden Feldern berechnet wurde, spiegelt möglicherweise nicht das tatsächliche klinische Bild wider.
Übersprungene Felder sind im Fortschrittsbalken hervorgehoben.
:::

:::danger Nicht für den klinischen Einsatz
Verwenden Sie diesen Score __nicht__ für echte Patientenentscheidungen.
:::

---

## Inline-Formatierung

Normaler Text mit **fett**, *kursiv*, __unterstrichen__ und `Festbreitenschrift` als Inline-Formatierung.
Verwenden Sie `---` für einen Gedankenstrich --- wie hier. Verwenden Sie `--` für Bereiche wie 10--20.
Drei Punkte werden zu einem Auslassungszeichen...

---

## Listen

Ungeordnete Liste:

- Erster Eintrag
- Zweiter Eintrag mit **fettem Text**
- Dritter Eintrag
  - Untergeordneter Eintrag A
  - Untergeordneter Eintrag B

Geordnete Liste:

1. Alle Variablenwerte erfassen
2. Punkte addieren
3. Ergebnis interpretieren

---

## Blockzitat

> „Alle Modelle sind falsch, aber manche sind nützlich."
>
> --- George Box

---

## Code

Inline: `score = vitalzeichen + respiratorisch + risikofaktoren`

Block:

```
if (o2Therapie == true) score += 2;
if (bewusstsein == 'sprache') score += 1;
if (bewusstsein == 'keineReaktion') score += 2;
```

---

## Links

Quellcode verfügbar auf [GitHub](https://github.com/lukas-schmdt/scores2go).

---

## Fußnoten

Die Scoring-Logik wurde von etablierten Schweregradindices inspiriert.[^1]
Die Temperaturkorrektur für die Einheitenumrechnung folgt Standardformeln.[^2]

[^1]: Knaus WA et al. APACHE II. Crit Care Med. 1985.
[^2]: °F = °C × 9/5 + 32

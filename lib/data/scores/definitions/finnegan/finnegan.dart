import 'package:scores_2_go/data/scores/definitions/finnegan/finnegan_function.dart';
import 'package:scores_2_go/data/scores/definitions/finnegan/finnegan_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/finnegan/finnegan_visibility.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = FinneganI10n();

Score buildFinneganScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 6,
    name: 'finnegan',
    display: t('display'),
    description: t('description'),
    author: 'Finnegan et al.',
    year: 1975,
    popularity: 82,
    categories: ['Neonatology', 'NAS'],
    docUrl: (locale) => locale == 'de'
        ? 'https://scores2go.com/scores/de/finnegan.html'
        : 'https://scores2go.com/scores/finnegan.html',
    scoreFunction: (s) => finneganFunction(s, lang),
    visibilityFunction: finneganVisibility,
    groups: [
      // ── Central Nervous System ───────────────────────────────────────────────
      Group(
        name: 'finnegan-cns',
        display: t('cns.group.display'),
        description: t('cns.group.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'finnegan-cry',
            display: t('cry.display'),
            description: t('cry.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('cry.0'), value: 0),
              VariableOption(display: t('cry.2'), value: 2),
              VariableOption(display: t('cry.3'), value: 3),
            ],
          ),
          VariableSelection(
            name: 'finnegan-sleep',
            display: t('sleep.display'),
            description: t('sleep.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('sleep.0'), value: 0),
              VariableOption(display: t('sleep.1'), value: 1),
              VariableOption(display: t('sleep.2'), value: 2),
              VariableOption(display: t('sleep.3'), value: 3),
            ],
          ),
          VariableSelection(
            name: 'finnegan-moro',
            display: t('moro.display'),
            description: t('moro.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('moro.0'), value: 0),
              VariableOption(display: t('moro.2'), value: 2),
              VariableOption(display: t('moro.3'), value: 3),
            ],
          ),
          VariableSelection(
            name: 'finnegan-tremors-disturbed',
            display: t('tremors-disturbed.display'),
            description: t('tremors-disturbed.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('tremors-disturbed.0'), value: 0),
              VariableOption(display: t('tremors-disturbed.1'), value: 1),
              VariableOption(display: t('tremors-disturbed.2'), value: 2),
            ],
          ),
          VariableSelection(
            name: 'finnegan-tremors-undisturbed',
            display: t('tremors-undisturbed.display'),
            description: t('tremors-undisturbed.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('tremors-undisturbed.0'), value: 0),
              VariableOption(display: t('tremors-undisturbed.3'), value: 3),
              VariableOption(display: t('tremors-undisturbed.4'), value: 4),
            ],
          ),
          VariableBool(
            name: 'finnegan-muscle-tone',
            display: t('muscle-tone.display'),
            description: t('muscle-tone.description'),
            value: null,
            trueValue: 2,
            falseValue: 0,
          ),
          VariableBool(
            name: 'finnegan-excoriation',
            display: t('excoriation.display'),
            description: t('excoriation.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'finnegan-myoclonic-jerks',
            display: t('myoclonic-jerks.display'),
            description: t('myoclonic-jerks.description'),
            value: null,
            trueValue: 3,
            falseValue: 0,
          ),
          VariableBool(
            name: 'finnegan-convulsions',
            display: t('convulsions.display'),
            description: t('convulsions.description'),
            value: null,
            trueValue: 5,
            falseValue: 0,
          ),
        ],
      ),

      // ── Metabolic / Vasomotor / Respiratory ──────────────────────────────────
      Group(
        name: 'finnegan-mvr',
        display: t('mvr.group.display'),
        description: t('mvr.group.description'),
        isVisible: true,
        items: [
          VariableBool(
            name: 'finnegan-sweating',
            display: t('sweating.display'),
            description: t('sweating.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableSelection(
            name: 'finnegan-fever',
            display: t('fever.display'),
            description: t('fever.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('fever.0'), value: 0),
              VariableOption(display: t('fever.1'), value: 1),
              VariableOption(display: t('fever.2'), value: 2),
            ],
          ),
          VariableBool(
            name: 'finnegan-yawning',
            display: t('yawning.display'),
            description: t('yawning.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'finnegan-mottling',
            display: t('mottling.display'),
            description: t('mottling.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'finnegan-nasal-stuffiness',
            display: t('nasal-stuffiness.display'),
            description: t('nasal-stuffiness.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'finnegan-sneezing',
            display: t('sneezing.display'),
            description: t('sneezing.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'finnegan-nasal-flaring',
            display: t('nasal-flaring.display'),
            description: t('nasal-flaring.description'),
            value: null,
            trueValue: 2,
            falseValue: 0,
          ),
          VariableSelection(
            name: 'finnegan-respiratory-rate',
            display: t('respiratory-rate.display'),
            description: t('respiratory-rate.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('respiratory-rate.0'), value: 0),
              VariableOption(display: t('respiratory-rate.1'), value: 1),
              VariableOption(display: t('respiratory-rate.2'), value: 2),
            ],
          ),
          VariableBool(
            name: 'finnegan-retractions',
            display: t('retractions.display'),
            description: t('retractions.description'),
            value: null,
            trueValue: 2,
            falseValue: 0,
          ),
        ],
      ),

      // ── Gastrointestinal ─────────────────────────────────────────────────────
      Group(
        name: 'finnegan-gi',
        display: t('gi.group.display'),
        description: t('gi.group.description'),
        isVisible: true,
        items: [
          VariableBool(
            name: 'finnegan-sucking',
            display: t('sucking.display'),
            description: t('sucking.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'finnegan-feeding',
            display: t('feeding.display'),
            description: t('feeding.description'),
            value: null,
            trueValue: 2,
            falseValue: 0,
          ),
          VariableBool(
            name: 'finnegan-regurgitation',
            display: t('regurgitation.display'),
            description: t('regurgitation.description'),
            value: null,
            trueValue: 2,
            falseValue: 0,
          ),
          VariableBool(
            name: 'finnegan-vomiting',
            display: t('vomiting.display'),
            description: t('vomiting.description'),
            value: null,
            trueValue: 3,
            falseValue: 0,
          ),
          VariableSelection(
            name: 'finnegan-stools',
            display: t('stools.display'),
            description: t('stools.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('stools.0'), value: 0),
              VariableOption(display: t('stools.2'), value: 2),
              VariableOption(display: t('stools.3'), value: 3),
            ],
          ),
        ],
      ),
    ],
  );
}

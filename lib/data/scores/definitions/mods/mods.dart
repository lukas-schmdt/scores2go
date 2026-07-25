import 'package:scores_2_go/data/scores/definitions/mods/mods_function.dart';
import 'package:scores_2_go/data/scores/definitions/mods/mods_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/mods/mods_visibility.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = ModsI10n();

Score buildModsScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 11,
    name: 'mods',
    display: t('display'),
    description: t('description'),
    author: 'Marshall et al.',
    year: 1995,
    popularity: 75,
    categories: ['ICU', 'Severity', 'Critical Care'],
    docUrl: (locale) => locale == 'de'
        ? 'https://scores2go.com/scores/de/mods.html'
        : 'https://scores2go.com/scores/mods.html',
    scoreFunction: (s) => modsFunction(s, lang),
    visibilityFunction: modsVisibility,
    groups: [
      // ── Respiratory ─────────────────────────────────────────────────────────
      Group(
        name: 'mods-respiratory',
        display: t('respiratory.group.display'),
        description: t('respiratory.group.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'mods-pf',
            display: t('pf.display'),
            description: t('pf.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('pf.0'), value: 0),
              VariableOption(display: t('pf.1'), value: 1),
              VariableOption(display: t('pf.2'), value: 2),
              VariableOption(display: t('pf.3'), value: 3),
              VariableOption(display: t('pf.4'), value: 4),
            ],
          ),
        ],
      ),

      // ── Renal ────────────────────────────────────────────────────────────────
      Group(
        name: 'mods-renal',
        display: t('renal.group.display'),
        description: t('renal.group.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'mods-creatinine',
            display: t('creatinine.display'),
            description: t('creatinine.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('creatinine.0'), value: 0),
              VariableOption(display: t('creatinine.1'), value: 1),
              VariableOption(display: t('creatinine.2'), value: 2),
              VariableOption(display: t('creatinine.3'), value: 3),
              VariableOption(display: t('creatinine.4'), value: 4),
            ],
          ),
        ],
      ),

      // ── Hepatic ──────────────────────────────────────────────────────────────
      Group(
        name: 'mods-hepatic',
        display: t('hepatic.group.display'),
        description: t('hepatic.group.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'mods-bilirubin',
            display: t('bilirubin.display'),
            description: t('bilirubin.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('bilirubin.0'), value: 0),
              VariableOption(display: t('bilirubin.1'), value: 1),
              VariableOption(display: t('bilirubin.2'), value: 2),
              VariableOption(display: t('bilirubin.3'), value: 3),
              VariableOption(display: t('bilirubin.4'), value: 4),
            ],
          ),
        ],
      ),

      // ── Cardiovascular ───────────────────────────────────────────────────────
      Group(
        name: 'mods-cardiovascular',
        display: t('cardiovascular.group.display'),
        description: t('cardiovascular.group.description'),
        isVisible: true,
        items: [
          VariableNumber(
            name: 'mods-hr',
            display: t('hr.display'),
            description: t('hr.description'),
            value: null,
            normMin: 60,
            normMax: 100,
          ),
          VariableNumber(
            name: 'mods-map',
            display: t('map.display'),
            description: t('map.description'),
            value: null,
            normMin: 70,
            normMax: 100,
          ),
          VariableNumber(
            name: 'mods-cvp',
            display: t('cvp.display'),
            description: t('cvp.description'),
            value: null,
            normMin: 2,
            normMax: 8,
          ),
        ],
      ),

      // ── Hematologic ──────────────────────────────────────────────────────────
      Group(
        name: 'mods-hematologic',
        display: t('hematologic.group.display'),
        description: t('hematologic.group.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'mods-platelets',
            display: t('platelets.display'),
            description: t('platelets.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('platelets.0'), value: 0),
              VariableOption(display: t('platelets.1'), value: 1),
              VariableOption(display: t('platelets.2'), value: 2),
              VariableOption(display: t('platelets.3'), value: 3),
              VariableOption(display: t('platelets.4'), value: 4),
            ],
          ),
        ],
      ),

      // ── Neurologic ───────────────────────────────────────────────────────────
      Group(
        name: 'mods-neurologic',
        display: t('neurologic.group.display'),
        description: t('neurologic.group.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'mods-gcs',
            display: t('gcs.display'),
            description: t('gcs.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('gcs.0'), value: 0),
              VariableOption(display: t('gcs.1'), value: 1),
              VariableOption(display: t('gcs.2'), value: 2),
              VariableOption(display: t('gcs.3'), value: 3),
              VariableOption(display: t('gcs.4'), value: 4),
            ],
          ),
        ],
      ),
    ],
  );
}

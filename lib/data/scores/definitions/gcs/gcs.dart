import 'package:scores_2_go/data/scores/definitions/gcs/gcs_function.dart';
import 'package:scores_2_go/data/scores/definitions/gcs/gcs_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/gcs/gcs_visibility.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = GcsI10n();

Score buildGcsScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 4,
    name: 'gcs',
    display: t('display'),
    description: t('description'),
    author: 'Teasdale & Jennett',
    year: 1974,
    popularity: 98,
    categories: ['Neurology', 'ICU', 'Emergency'],
    docUrl: (locale) => locale == 'de'
        ? 'https://scores2go.com/scores/de/gcs.html'
        : 'https://scores2go.com/scores/gcs.html',
    scoreFunction: (s) => gcsFunction(s, lang),
    visibilityFunction: gcsVisibility,
    groups: [
      Group(
        name: 'gcs-eyes',
        display: t('eyes.group.display'),
        description: t('eyes.group.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'gcs-eyes',
            display: t('eyes.display'),
            description: t('eyes.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('eyes.4'), value: 4),
              VariableOption(display: t('eyes.3'), value: 3),
              VariableOption(display: t('eyes.2'), value: 2),
              VariableOption(display: t('eyes.1'), value: 1),
              VariableOption(display: t('eyes.nt'), value: -1),
            ],
          ),
        ],
      ),
      Group(
        name: 'gcs-verbal',
        display: t('verbal.group.display'),
        description: t('verbal.group.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'gcs-verbal',
            display: t('verbal.display'),
            description: t('verbal.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('verbal.5'), value: 5),
              VariableOption(display: t('verbal.4'), value: 4),
              VariableOption(display: t('verbal.3'), value: 3),
              VariableOption(display: t('verbal.2'), value: 2),
              VariableOption(display: t('verbal.1'), value: 1),
              VariableOption(display: t('verbal.nt'), value: -1),
            ],
          ),
        ],
      ),
      Group(
        name: 'gcs-motor',
        display: t('motor.group.display'),
        description: t('motor.group.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'gcs-motor',
            display: t('motor.display'),
            description: t('motor.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('motor.6'), value: 6),
              VariableOption(display: t('motor.5'), value: 5),
              VariableOption(display: t('motor.4'), value: 4),
              VariableOption(display: t('motor.3'), value: 3),
              VariableOption(display: t('motor.2'), value: 2),
              VariableOption(display: t('motor.1'), value: 1),
              VariableOption(display: t('motor.nt'), value: -1),
            ],
          ),
        ],
      ),
    ],
  );
}

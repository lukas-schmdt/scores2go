import 'package:scores_2_go/data/scores/definitions/nudesc/nudesc_function.dart';
import 'package:scores_2_go/data/scores/definitions/nudesc/nudesc_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/nudesc/nudesc_visibility.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = NudescI10n();

Score buildNudescScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 13,
    name: 'nudesc',
    display: t('display'),
    description: t('description'),
    author: 'Gaudreau et al.',
    year: 2005,
    popularity: 70,
    categories: ['Delirium', 'ICU', 'Nursing'],
    doc: (_) => 'lib/data/scores/definitions/nudesc/nudesc_doc.md',
    docUrl: (locale) => locale == 'de'
        ? 'https://scores2go.com/scores/de/nudesc'
        : 'https://scores2go.com/scores/nudesc',
    scoreFunction: nudescFunction,
    visibilityFunction: nudescVisibility,
    groups: [
      Group(
        name: 'nudesc-assessment',
        display: t('group.display'),
        description: t('group.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'nudesc-disorientation',
            display: t('disorientation.display'),
            description: t('disorientation.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('opt.absent'), value: 0),
              VariableOption(display: t('opt.mild'), value: 1),
              VariableOption(display: t('opt.present'), value: 2),
            ],
          ),
          VariableSelection(
            name: 'nudesc-inappropriate-behavior',
            display: t('inappropriate-behavior.display'),
            description: t('inappropriate-behavior.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('opt.absent'), value: 0),
              VariableOption(display: t('opt.mild'), value: 1),
              VariableOption(display: t('opt.present'), value: 2),
            ],
          ),
          VariableSelection(
            name: 'nudesc-inappropriate-communication',
            display: t('inappropriate-communication.display'),
            description: t('inappropriate-communication.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('opt.absent'), value: 0),
              VariableOption(display: t('opt.mild'), value: 1),
              VariableOption(display: t('opt.present'), value: 2),
            ],
          ),
          VariableSelection(
            name: 'nudesc-illusions',
            display: t('illusions.display'),
            description: t('illusions.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('opt.absent'), value: 0),
              VariableOption(display: t('opt.mild'), value: 1),
              VariableOption(display: t('opt.present'), value: 2),
            ],
          ),
          VariableSelection(
            name: 'nudesc-psychomotor-retardation',
            display: t('psychomotor-retardation.display'),
            description: t('psychomotor-retardation.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('opt.absent'), value: 0),
              VariableOption(display: t('opt.mild'), value: 1),
              VariableOption(display: t('opt.present'), value: 2),
            ],
          ),
        ],
      ),
    ],
  );
}

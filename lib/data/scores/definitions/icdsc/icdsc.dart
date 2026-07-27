import 'package:scores_2_go/data/scores/definitions/icdsc/icdsc_function.dart';
import 'package:scores_2_go/data/scores/definitions/icdsc/icdsc_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/icdsc/icdsc_visibility.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = IcdscI10n();

Score buildIcdscScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 19,
    name: 'icdsc',
    display: t('display'),
    description: t('description'),
    author: 'Bergeron et al.',
    year: 2001,
    popularity: 75,
    categories: ['Delirium', 'ICU', 'Nursing'],
    docUrl: (locale) => locale == 'de'
        ? 'https://scores2go.com/scores/de/icdsc.html'
        : 'https://scores2go.com/scores/icdsc.html',
    scoreFunction: (s) => icdscFunction(s, lang),
    visibilityFunction: icdscVisibility,
    groups: [
      Group(
        name: 'icdsc-assessment',
        display: t('group.display'),
        description: t('group.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'icdsc-loc',
            display: t('loc.display'),
            description: t('loc.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('loc.opt.a'), value: -1),
              VariableOption(display: t('loc.opt.b'), value: -1),
              VariableOption(display: t('loc.opt.c'), value: 1),
              VariableOption(display: t('loc.opt.d'), value: 0),
              VariableOption(display: t('loc.opt.e'), value: 1),
            ],
          ),
          VariableBool(
            name: 'icdsc-inattention',
            display: t('inattention.display'),
            description: t('inattention.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'icdsc-disorientation',
            display: t('disorientation.display'),
            description: t('disorientation.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'icdsc-hallucinations',
            display: t('hallucinations.display'),
            description: t('hallucinations.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'icdsc-psychomotor',
            display: t('psychomotor.display'),
            description: t('psychomotor.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'icdsc-speech-mood',
            display: t('speech-mood.display'),
            description: t('speech-mood.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'icdsc-sleep-wake',
            display: t('sleep-wake.display'),
            description: t('sleep-wake.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'icdsc-fluctuation',
            display: t('fluctuation.display'),
            description: t('fluctuation.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
        ],
      ),
    ],
  );
}

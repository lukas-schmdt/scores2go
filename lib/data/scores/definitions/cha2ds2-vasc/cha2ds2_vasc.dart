import 'package:scores_2_go/data/scores/definitions/cha2ds2-vasc/cha2ds2_vasc_function.dart';
import 'package:scores_2_go/data/scores/definitions/cha2ds2-vasc/cha2ds2_vasc_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/cha2ds2-vasc/cha2ds2_vasc_visibility.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = Cha2ds2VascI10n();

Score buildCha2ds2VascScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 18,
    name: 'cha2ds2-vasc',
    display: t('display'),
    description: t('description'),
    scoreFunction: (s) => cha2ds2VascFunction(s, lang),
    visibilityFunction: cha2ds2VascVisibility,
    docUrl: (locale) => locale == 'de'
        ? 'https://scores2go.com/scores/de/cha2ds2-vasc.html'
        : 'https://scores2go.com/scores/cha2ds2-vasc.html',
    author: 'Lip et al.',
    year: 2010,
    popularity: 90,
    categories: ['Cardiology', 'Stroke Risk'],
    groups: [
      Group(
        name: 'cha2ds2-vasc-risk-factors',
        display: t('group.risk-factors.display'),
        description: t('group.risk-factors.description'),
        isVisible: true,
        items: [
          VariableBool(
            name: 'cha2ds2-vasc-chf',
            display: t('chf.display'),
            description: t('chf.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'cha2ds2-vasc-hypertension',
            display: t('hypertension.display'),
            description: t('hypertension.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableSelection(
            name: 'cha2ds2-vasc-age',
            display: t('age.display'),
            description: t('age.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('age.opt.lt65'), value: 0),
              VariableOption(display: t('age.opt.65_74'), value: 1),
              VariableOption(display: t('age.opt.ge75'), value: 2),
            ],
          ),
          VariableBool(
            name: 'cha2ds2-vasc-diabetes',
            display: t('diabetes.display'),
            description: t('diabetes.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'cha2ds2-vasc-stroke-tia',
            display: t('stroke-tia.display'),
            description: t('stroke-tia.description'),
            value: null,
            trueValue: 2,
            falseValue: 0,
          ),
          VariableBool(
            name: 'cha2ds2-vasc-vascular-disease',
            display: t('vascular-disease.display'),
            description: t('vascular-disease.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableSelection(
            name: 'cha2ds2-vasc-sex',
            display: t('sex.display'),
            description: t('sex.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('sex.opt.female'), value: 1),
              VariableOption(display: t('sex.opt.male'), value: 0),
            ],
          ),
        ],
      ),
    ],
  );
}

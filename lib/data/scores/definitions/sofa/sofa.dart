import 'package:scores_2_go/data/scores/definitions/sofa/sofa_function.dart';
import 'package:scores_2_go/data/scores/definitions/sofa/sofa_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/sofa/sofa_visibility.dart';
import 'package:scores_2_go/function/value_unit_converter.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = SofaI10n();

Score buildSofaScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 3,
    name: 'sofa',
    scoreFunction: sofaFunction,
    visibilityFunction: sofaVisibility,
    docUrl: (locale) => locale == 'de'
        ? 'https://scores2go.com/scores/de/sofa.html'
        : 'https://scores2go.com/scores/sofa.html',
    author: 'Vincent et al.',
    year: 1996,
    popularity: 92,
    categories: ['Sepsis', 'ICU'],
    display: 'SOFA',
    description: t('description'),
    groups: [
      Group(
        name: 'sofa-respiration',
        display: t('group.respiration'),
        description: t('group.respiration.description'),
        isVisible: true,
        items: [
          VariableBool(
            name: 'sofa-respiratory_support',
            display: t('respiratory_support.display'),
            description: t('respiratory_support.description'),
            value: null,
            trueValue: 0,
            falseValue: 0,
          ),
          VariableSelection(
            name: 'sofa-pao2_fio2',
            display: t('pao2_fio2.display'),
            description: t('pao2_fio2.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: '≥ 400 mmHg', value: 0),
              VariableOption(display: '< 400 mmHg', value: 1),
              VariableOption(display: '< 300 mmHg', value: 2),
              VariableOption(display: t('pao2_fio2.opt.200_support'), value: 3),
              VariableOption(display: t('pao2_fio2.opt.100_support'), value: 4),
            ],
          ),
        ],
      ),
      Group(
        name: 'sofa-coagulation',
        display: t('group.coagulation'),
        description: t('group.coagulation.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'sofa-platelets',
            display: t('platelets.display'),
            description: t('platelets.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: '≥ 150 ×10³/µL', value: 0),
              VariableOption(display: '< 150 ×10³/µL', value: 1),
              VariableOption(display: '< 100 ×10³/µL', value: 2),
              VariableOption(display: '< 50 ×10³/µL', value: 3),
              VariableOption(display: '< 20 ×10³/µL', value: 4),
            ],
          ),
        ],
      ),
      Group(
        name: 'sofa-liver',
        display: t('group.liver'),
        description: t('group.liver.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'sofa-bilirubin',
            display: t('bilirubin.display'),
            description: t('bilirubin.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: '< 1,2 mg/dL', value: 0),
              VariableOption(display: '1,2 – 1,9 mg/dL', value: 1),
              VariableOption(display: '2,0 – 5,9 mg/dL', value: 2),
              VariableOption(display: '6,0 – 11,9 mg/dL', value: 3),
              VariableOption(display: '≥ 12,0 mg/dL', value: 4),
            ],
          ),
        ],
      ),
      Group(
        name: 'sofa-cardiovascular',
        display: t('group.cardiovascular'),
        description: t('group.cardiovascular.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'sofa-cardiovascular_status',
            display: t('cardiovascular_status.display'),
            description: t('cardiovascular_status.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: 'MAP ≥ 70 mmHg', value: 0),
              VariableOption(
                display: t('cardiovascular_status.opt.map_low'),
                value: 1,
              ),
              VariableOption(
                display: t('cardiovascular_status.opt.dopa_low'),
                value: 2,
              ),
              VariableOption(
                display: t('cardiovascular_status.opt.dopa_mid'),
                value: 3,
              ),
              VariableOption(
                display: t('cardiovascular_status.opt.dopa_high'),
                value: 4,
              ),
            ],
          ),
        ],
      ),
      Group(
        name: 'sofa-cns',
        display: t('group.cns'),
        description: t('group.cns.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'sofa-gcs',
            display: t('gcs.display'),
            description: t('gcs.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: '15', value: 0),
              VariableOption(display: '13 – 14', value: 1),
              VariableOption(display: '10 – 12', value: 2),
              VariableOption(display: '6 – 9', value: 3),
              VariableOption(display: '< 6', value: 4),
            ],
          ),
        ],
      ),
      Group(
        name: 'sofa-renal',
        display: t('group.renal'),
        description: t('group.renal.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'sofa-creatinine',
            display: t('creatinine.display'),
            description: t('creatinine.description'),
            type: VariableType.select,
            units: Units.creatinine,
            options: [
              VariableOption(
                display: '< 1,2 mg/dL',
                displays: ['< 1,2 mg/dL', '< 110 µmol/L'],
                value: 0,
              ),
              VariableOption(
                display: '1,2 – 1,9 mg/dL',
                displays: ['1,2 – 1,9 mg/dL', '110 – 170 µmol/L'],
                value: 1,
              ),
              VariableOption(
                display: '2,0 – 3,4 mg/dL',
                displays: ['2,0 – 3,4 mg/dL', '171 – 299 µmol/L'],
                value: 2,
              ),
              VariableOption(
                display: '3,5 – 4,9 mg/dL',
                displays: ['3,5 – 4,9 mg/dL', '300 – 440 µmol/L'],
                value: 3,
              ),
              VariableOption(
                display: '≥ 5,0 mg/dL',
                displays: ['≥ 5,0 mg/dL', '≥ 440 µmol/L'],
                value: 4,
              ),
            ],
          ),
          VariableSelection(
            name: 'sofa-urine_output',
            display: t('urine_output.display'),
            description: t('urine_output.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: '≥ 500 mL/Tag', value: 0),
              VariableOption(display: t('urine_output.opt.lt500'), value: 3),
              VariableOption(display: t('urine_output.opt.lt200'), value: 4),
            ],
          ),
        ],
      ),
    ],
  );
}

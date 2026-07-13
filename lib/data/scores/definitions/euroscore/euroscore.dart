import 'package:scores_2_go/data/scores/definitions/euroscore/euroscore_function.dart';
import 'package:scores_2_go/data/scores/definitions/euroscore/euroscore_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/euroscore/euroscore_visibility.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = EuroscoreI10n();

Score buildEuroscoreScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 9,
    name: 'euroscore',
    docUrl: (locale) => locale == 'de'
        ? 'https://scores2go.com/scores/de/euroscore2.html'
        : 'https://scores2go.com/scores/euroscore2.html',
    scoreFunction: euroscoreFunction,
    visibilityFunction: euroscoreVisibility,
    author: 'Nashef et al.',
    year: 2012,
    popularity: 85,
    categories: ['Cardiac Surgery', 'Mortality'],
    display: t('display'),
    description: t('description'),
    groups: [
      Group(
        name: 'euroscore-patient',
        display: t('group.patient.display'),
        description: t('group.patient.description'),
        isVisible: true,
        items: [
          VariableNumber(
            name: 'euroscore-age',
            display: t('age.display'),
            description: t('age.description'),
            value: null,
            normMin: 0,
            normMax: 120,
          ),
          VariableBool(
            name: 'euroscore-female',
            display: t('female.display'),
            description: t('female.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'euroscore-creatinine_high',
            display: t('creatinine_high.display'),
            description: t('creatinine_high.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'euroscore-arteriopathy',
            display: t('arteriopathy.display'),
            description: t('arteriopathy.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'euroscore-poor_mobility',
            display: t('poor_mobility.display'),
            description: t('poor_mobility.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'euroscore-prev_surgery',
            display: t('prev_surgery.display'),
            description: t('prev_surgery.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'euroscore-copd',
            display: t('copd.display'),
            description: t('copd.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'euroscore-endocarditis',
            display: t('endocarditis.display'),
            description: t('endocarditis.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'euroscore-critical_state',
            display: t('critical_state.display'),
            description: t('critical_state.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'euroscore-diabetes_insulin',
            display: t('diabetes_insulin.display'),
            description: t('diabetes_insulin.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableSelection(
            name: 'euroscore-nyha',
            display: t('nyha.display'),
            description: t('nyha.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('nyha.1'), value: 0.0),
              VariableOption(display: t('nyha.2'), value: 0.1082900),
              VariableOption(display: t('nyha.3'), value: 0.2962689),
              VariableOption(display: t('nyha.4'), value: 0.5462446),
            ],
          ),
          VariableBool(
            name: 'euroscore-ccs4',
            display: t('ccs4.display'),
            description: t('ccs4.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
        ],
      ),
      Group(
        name: 'euroscore-cardiac',
        display: t('group.cardiac.display'),
        description: t('group.cardiac.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'euroscore-lv_function',
            display: t('lv_function.display'),
            description: t('lv_function.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('lv_function.good'), value: 0.0),
              VariableOption(display: t('lv_function.moderate'), value: 0.3150652),
              VariableOption(display: t('lv_function.poor'), value: 0.8084096),
              VariableOption(display: t('lv_function.very_poor'), value: 0.9346919),
            ],
          ),
          VariableBool(
            name: 'euroscore-recent_mi',
            display: t('recent_mi.display'),
            description: t('recent_mi.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableSelection(
            name: 'euroscore-pulm_htn',
            display: t('pulm_htn.display'),
            description: t('pulm_htn.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('pulm_htn.no'), value: 0.0),
              VariableOption(display: t('pulm_htn.moderate'), value: 0.1788899),
              VariableOption(display: t('pulm_htn.severe'), value: 0.3491475),
            ],
          ),
        ],
      ),
      Group(
        name: 'euroscore-operation',
        display: t('group.operation.display'),
        description: t('group.operation.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'euroscore-urgency',
            display: t('urgency.display'),
            description: t('urgency.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('urgency.elective'), value: 0.0),
              VariableOption(display: t('urgency.urgent'), value: 0.3174673),
              VariableOption(display: t('urgency.emergency'), value: 0.7039121),
              VariableOption(display: t('urgency.salvage'), value: 1.3337492),
            ],
          ),
          VariableSelection(
            name: 'euroscore-procedure',
            display: t('procedure.display'),
            description: t('procedure.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('procedure.cabg'), value: 0.0),
              VariableOption(display: t('procedure.single_non_cabg'), value: 0.0062118),
              VariableOption(display: t('procedure.two'), value: 0.5521478),
              VariableOption(display: t('procedure.three_plus'), value: 0.9724533),
            ],
          ),
          VariableBool(
            name: 'euroscore-thoracic_aorta',
            display: t('thoracic_aorta.display'),
            description: t('thoracic_aorta.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'euroscore-septal_rupture',
            display: t('septal_rupture.display'),
            description: t('septal_rupture.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
        ],
      ),
    ],
  );
}

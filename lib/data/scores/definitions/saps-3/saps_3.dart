import 'package:scores_2_go/data/scores/definitions/saps-3/saps_3_function.dart';
import 'package:scores_2_go/data/scores/definitions/saps-3/saps_3_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/saps-3/saps_3_visibility.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = Saps3I10n();

Score buildSaps3Score(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 10,
    name: 'saps3',
    doc: (_) => 'lib/data/scores/definitions/saps-3/saps_3_doc.md',
    scoreFunction: saps3Function,
    visibilityFunction: saps3Visibility,
    author: 'Moreno et al.',
    year: 2005,
    popularity: 78,
    categories: ['ICU', 'Mortality'],
    display: t('display'),
    description: t('description'),
    groups: [
      // Box I – Patient information
      Group(
        name: 'saps3-patient',
        display: t('group.patient.display'),
        description: t('group.patient.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'saps3-age',
            display: t('age.display'),
            description: t('age.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('age.lt40'), value: 0),
              VariableOption(display: t('age.40_59'), value: 5),
              VariableOption(display: t('age.60_69'), value: 9),
              VariableOption(display: t('age.70_74'), value: 13),
              VariableOption(display: t('age.75_79'), value: 15),
              VariableOption(display: t('age.ge80'), value: 18),
            ],
          ),
          VariableSelection(
            name: 'saps3-comorbidities',
            display: t('comorbidities.display'),
            description: t('comorbidities.description'),
            type: VariableType.multiselect,
            options: [
              VariableOption(display: t('comorbidities.chf4'), value: 6),
              VariableOption(display: t('comorbidities.cirrhosis'), value: 4),
              VariableOption(display: t('comorbidities.alcohol'), value: 3),
              VariableOption(display: t('comorbidities.neoplasm'), value: 6),
              VariableOption(display: t('comorbidities.haematological'), value: 6),
              VariableOption(display: t('comorbidities.metastatic'), value: 9),
              VariableOption(display: t('comorbidities.aids'), value: 8),
            ],
          ),
          VariableBool(
            name: 'saps3-ventilated',
            display: t('ventilated.display'),
            description: t('ventilated.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
        ],
      ),
      // Box II – ICU admission circumstances
      Group(
        name: 'saps3-admission',
        display: t('group.admission.display'),
        description: t('group.admission.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'saps3-location',
            display: t('location.display'),
            description: t('location.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('location.recovery'), value: -6),
              VariableOption(display: t('location.er'), value: 0),
              VariableOption(display: t('location.other_hospital'), value: 0),
              VariableOption(display: t('location.ward'), value: 6),
              VariableOption(display: t('location.direct'), value: 0),
            ],
          ),
          VariableBool(
            name: 'saps3-surgical',
            display: t('surgical.display'),
            description: t('surgical.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableSelection(
            name: 'saps3-reason',
            display: t('reason.display'),
            description: t('reason.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('reason.medical'), value: 0),
              VariableOption(display: t('reason.sepsis'), value: 5),
              VariableOption(display: t('reason.resp'), value: 4),
              VariableOption(display: t('reason.cardiac_arrest'), value: 10),
              VariableOption(display: t('reason.cardiac_rhythm'), value: 5),
              VariableOption(display: t('reason.trauma'), value: -8),
              VariableOption(display: t('reason.intoxication'), value: -13),
              VariableOption(display: t('reason.intracranial'), value: 7),
              VariableOption(display: t('reason.metabolic'), value: 5),
              VariableOption(display: t('reason.gi'), value: 5),
              VariableOption(display: t('reason.surgery_elective'), value: -6),
            ],
          ),
        ],
      ),
      // Box III – Acute physiology
      Group(
        name: 'saps3-physiology',
        display: t('group.physiology.display'),
        description: t('group.physiology.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'saps3-gcs',
            display: t('gcs.display'),
            description: t('gcs.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('gcs.15'), value: 0),
              VariableOption(display: t('gcs.13_14'), value: 4),
              VariableOption(display: t('gcs.10_12'), value: 7),
              VariableOption(display: t('gcs.7_9'), value: 10),
              VariableOption(display: t('gcs.4_6'), value: 15),
              VariableOption(display: t('gcs.3'), value: 15),
            ],
          ),
          VariableSelection(
            name: 'saps3-bilirubin',
            display: t('bilirubin.display'),
            description: t('bilirubin.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('bilirubin.lt2'), value: 0),
              VariableOption(display: t('bilirubin.2_6'), value: 4),
              VariableOption(display: t('bilirubin.6_9'), value: 5),
              VariableOption(display: t('bilirubin.ge9'), value: 6),
            ],
          ),
          VariableSelection(
            name: 'saps3-temperature',
            display: t('temperature.display'),
            description: t('temperature.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('temperature.lt35'), value: 4),
              VariableOption(display: t('temperature.35_40'), value: 0),
              VariableOption(display: t('temperature.ge40'), value: 3),
            ],
          ),
          VariableSelection(
            name: 'saps3-heart_rate',
            display: t('heart_rate.display'),
            description: t('heart_rate.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('heart_rate.lt40'), value: 11),
              VariableOption(display: t('heart_rate.40_59'), value: 2),
              VariableOption(display: t('heart_rate.60_119'), value: 0),
              VariableOption(display: t('heart_rate.120_159'), value: 4),
              VariableOption(display: t('heart_rate.ge160'), value: 7),
            ],
          ),
          VariableSelection(
            name: 'saps3-map',
            display: t('map.display'),
            description: t('map.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('map.lt40'), value: 18),
              VariableOption(display: t('map.40_69'), value: 7),
              VariableOption(display: t('map.70_119'), value: 0),
              VariableOption(display: t('map.ge120'), value: 3),
            ],
          ),
          VariableSelection(
            name: 'saps3-creatinine',
            display: t('creatinine.display'),
            description: t('creatinine.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('creatinine.lt1_2'), value: 0),
              VariableOption(display: t('creatinine.1_2_2'), value: 2),
              VariableOption(display: t('creatinine.2_3_5'), value: 7),
              VariableOption(display: t('creatinine.ge3_5'), value: 8),
            ],
          ),
          VariableSelection(
            name: 'saps3-platelets',
            display: t('platelets.display'),
            description: t('platelets.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('platelets.lt20'), value: 13),
              VariableOption(display: t('platelets.20_49'), value: 8),
              VariableOption(display: t('platelets.50_99'), value: 5),
              VariableOption(display: t('platelets.100_149'), value: 3),
              VariableOption(display: t('platelets.ge150'), value: 0),
            ],
          ),
          VariableSelection(
            name: 'saps3-wbc',
            display: t('wbc.display'),
            description: t('wbc.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('wbc.lt1'), value: 12),
              VariableOption(display: t('wbc.1_14'), value: 0),
              VariableOption(display: t('wbc.ge15'), value: 3),
            ],
          ),
          VariableSelection(
            name: 'saps3-ph',
            display: t('ph.display'),
            description: t('ph.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('ph.lt7'), value: 14),
              VariableOption(display: t('ph.7_7_24'), value: 11),
              VariableOption(display: t('ph.7_25_7_32'), value: 6),
              VariableOption(display: t('ph.7_33_7_49'), value: 0),
              VariableOption(display: t('ph.ge7_5'), value: 3),
            ],
          ),
          VariableSelection(
            name: 'saps3-pao2_fio2',
            display: t('pao2_fio2.display'),
            description: t('pao2_fio2.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('pao2_fio2.lt100'), value: 11),
              VariableOption(display: t('pao2_fio2.100_199'), value: 9),
              VariableOption(display: t('pao2_fio2.ge200'), value: 5),
            ],
          ),
        ],
      ),
    ],
  );
}

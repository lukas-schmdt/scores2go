import 'package:scores_2_go/data/scores/definitions/meld/meld_function.dart';
import 'package:scores_2_go/data/scores/definitions/meld/meld_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/meld/meld_visibility.dart';
import 'package:scores_2_go/function/value_unit_converter.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = MeldI10n();

Score buildMeldScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 5,
    name: 'meld',
    display: t('display'),
    description: t('description'),
    author: 'Kamath et al.',
    year: 2001,
    popularity: 88,
    categories: ['Hepatology', 'Transplant', 'Severity'],
    doc: (_) => 'lib/data/scores/definitions/meld/meld_doc.md',
    docUrl: (locale) => locale == 'de'
        ? 'https://scores2go.com/scores/de/meld'
        : 'https://scores2go.com/scores/meld',
    scoreFunction: meldFunction,
    visibilityFunction: meldVisibility,
    groups: [
      Group(
        name: 'meld-liver',
        display: t('liver.group.display'),
        description: t('liver.group.description'),
        isVisible: true,
        items: [
          VariableNumber(
            name: 'meld-bilirubin',
            display: t('bilirubin.display'),
            description: t('bilirubin.description'),
            value: null,
            normMin: 0.2,
            normMax: 1.2,
            units: Units.bilirubin,
          ),
        ],
      ),
      Group(
        name: 'meld-coagulation',
        display: t('coagulation.group.display'),
        description: t('coagulation.group.description'),
        isVisible: true,
        items: [
          VariableNumber(
            name: 'meld-inr',
            display: t('inr.display'),
            description: t('inr.description'),
            value: null,
            normMin: 0.8,
            normMax: 1.2,
          ),
        ],
      ),
      Group(
        name: 'meld-renal',
        display: t('renal.group.display'),
        description: t('renal.group.description'),
        isVisible: true,
        items: [
          VariableNumber(
            name: 'meld-creatinine',
            display: t('creatinine.display'),
            description: t('creatinine.description'),
            value: null,
            normMin: 0.5,
            normMax: 1.2,
            units: Units.creatinine,
          ),
          VariableBool(
            name: 'meld-dialysis',
            display: t('dialysis.display'),
            description: t('dialysis.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
        ],
      ),
    ],
  );
}

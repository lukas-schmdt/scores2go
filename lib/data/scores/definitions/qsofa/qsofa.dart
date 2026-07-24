import 'package:scores_2_go/data/scores/definitions/qsofa/qsofa_function.dart';
import 'package:scores_2_go/data/scores/definitions/qsofa/qsofa_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/qsofa/qsofa_visibility.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = QsofaI10n();

Score buildQsofaScore(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 17,
    name: 'qsofa',
    display: t('display'),
    description: t('description'),
    author: 'Seymour et al.',
    year: 2016,
    popularity: 80,
    categories: ['Sepsis', 'Emergency'],
    docUrl: (locale) => locale == 'de'
        ? 'https://scores2go.com/scores/de/qsofa.html'
        : 'https://scores2go.com/scores/qsofa.html',
    scoreFunction: qsofaFunction,
    visibilityFunction: qsofaVisibility,
    groups: [
      Group(
        name: 'qsofa-assessment',
        display: t('group.assessment.display'),
        description: t('group.assessment.description'),
        isVisible: true,
        items: [
          VariableBool(
            name: 'qsofa-resp-rate',
            display: t('resp-rate.display'),
            description: t('resp-rate.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'qsofa-mentation',
            display: t('mentation.display'),
            description: t('mentation.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
          VariableBool(
            name: 'qsofa-sbp',
            display: t('sbp.display'),
            description: t('sbp.description'),
            value: null,
            trueValue: 1,
            falseValue: 0,
          ),
        ],
      ),
    ],
  );
}

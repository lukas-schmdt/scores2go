import 'package:scores_2_go/data/scores/definitions/news2/news2_function.dart';
import 'package:scores_2_go/data/scores/definitions/news2/news2_i10n.dart';
import 'package:scores_2_go/data/scores/definitions/news2/news2_visibility.dart';
import 'package:scores_2_go/model/model.dart';

final _i10n = News2I10n();

Score buildNews2Score(String lang) {
  String t(String key) => _i10n.t(lang, key);
  return Score(
    id: 16,
    name: 'news2',
    display: t('display'),
    description: t('description'),
    scoreFunction: news2Function,
    visibilityFunction: news2Visibility,
    docUrl: (locale) => locale == 'de'
        ? 'https://scores2go.com/scores/de/news2.html'
        : 'https://scores2go.com/scores/news2.html',
    author: 'Royal College of Physicians',
    year: 2017,
    popularity: 85,
    categories: ['Emergency', 'Severity'],
    groups: [
      Group(
        name: 'news2-respiratory',
        display: t('group.respiratory.display'),
        description: t('group.respiratory.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'news2-rr',
            display: t('rr.display'),
            description: t('rr.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('rr.opt.le8'), value: 3),
              VariableOption(display: t('rr.opt.9to11'), value: 1),
              VariableOption(display: t('rr.opt.12to20'), value: 0),
              VariableOption(display: t('rr.opt.21to24'), value: 2),
              VariableOption(display: t('rr.opt.ge25'), value: 3),
            ],
          ),
          VariableBool(
            name: 'news2-hypercapnic',
            display: t('hypercapnic.display'),
            description: t('hypercapnic.description'),
            value: null,
            trueValue: 0,
            falseValue: 0,
          ),
          VariableSelection(
            name: 'news2-spo2-1',
            display: t('spo2-1.display'),
            description: t('spo2-1.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('spo2-1.opt.le91'), value: 3),
              VariableOption(display: t('spo2-1.opt.92to93'), value: 2),
              VariableOption(display: t('spo2-1.opt.94to95'), value: 1),
              VariableOption(display: t('spo2-1.opt.ge96'), value: 0),
            ],
          ),
          VariableSelection(
            name: 'news2-spo2-2',
            display: t('spo2-2.display'),
            description: t('spo2-2.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('spo2-2.opt.le83'), value: 3),
              VariableOption(display: t('spo2-2.opt.84to85'), value: 2),
              VariableOption(display: t('spo2-2.opt.86to87'), value: 1),
              VariableOption(display: t('spo2-2.opt.88to92'), value: 0),
              VariableOption(display: t('spo2-2.opt.93to94o2'), value: 1),
              VariableOption(display: t('spo2-2.opt.95to96o2'), value: 2),
              VariableOption(display: t('spo2-2.opt.ge97o2'), value: 3),
            ],
          ),
          VariableBool(
            name: 'news2-o2',
            display: t('o2.display'),
            description: t('o2.description'),
            value: null,
            trueValue: 2,
            falseValue: 0,
          ),
        ],
      ),
      Group(
        name: 'news2-cardiovascular',
        display: t('group.cardiovascular.display'),
        description: t('group.cardiovascular.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'news2-sbp',
            display: t('sbp.display'),
            description: t('sbp.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('sbp.opt.le90'), value: 3),
              VariableOption(display: t('sbp.opt.91to100'), value: 2),
              VariableOption(display: t('sbp.opt.101to110'), value: 1),
              VariableOption(display: t('sbp.opt.111to219'), value: 0),
              VariableOption(display: t('sbp.opt.ge220'), value: 3),
            ],
          ),
          VariableSelection(
            name: 'news2-pulse',
            display: t('pulse.display'),
            description: t('pulse.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('pulse.opt.le40'), value: 3),
              VariableOption(display: t('pulse.opt.41to50'), value: 1),
              VariableOption(display: t('pulse.opt.51to90'), value: 0),
              VariableOption(display: t('pulse.opt.91to110'), value: 1),
              VariableOption(display: t('pulse.opt.111to130'), value: 2),
              VariableOption(display: t('pulse.opt.ge131'), value: 3),
            ],
          ),
        ],
      ),
      Group(
        name: 'news2-neuro',
        display: t('group.neuro.display'),
        description: t('group.neuro.description'),
        isVisible: true,
        items: [
          VariableSelection(
            name: 'news2-consciousness',
            display: t('consciousness.display'),
            description: t('consciousness.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('consciousness.opt.a'), value: 0),
              VariableOption(display: t('consciousness.opt.c'), value: 3),
              VariableOption(display: t('consciousness.opt.v'), value: 3),
              VariableOption(display: t('consciousness.opt.p'), value: 3),
              VariableOption(display: t('consciousness.opt.u'), value: 3),
            ],
          ),
          VariableSelection(
            name: 'news2-temp',
            display: t('temp.display'),
            description: t('temp.description'),
            type: VariableType.select,
            options: [
              VariableOption(display: t('temp.opt.le35'), value: 3),
              VariableOption(display: t('temp.opt.35to36'), value: 1),
              VariableOption(display: t('temp.opt.36to38'), value: 0),
              VariableOption(display: t('temp.opt.38to39'), value: 1),
              VariableOption(display: t('temp.opt.ge39'), value: 2),
            ],
          ),
        ],
      ),
    ],
  );
}

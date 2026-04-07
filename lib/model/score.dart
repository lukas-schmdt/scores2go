import 'package:scores_2_go/model/score_group.dart';
import 'package:scores_2_go/model/score_result.dart';
import 'package:scores_2_go/model/score_visibility.dart';

class Score {
  final int id;
  final String name;
  final String display;
  final String description;
  final List<Group> groups;
  final ScoreResult Function(Score)? scoreFunction;
  final ScoreVisibility Function(Score)? visibilityFunction;

  Score({
    required this.id,
    required this.name,
    required this.display,
    required this.description,
    required this.groups,
    this.scoreFunction,
    this.visibilityFunction,
  });

  Score copyWith({
    int? id,
    String? name,
    String? display,
    String? description,
    List<Group>? groups,
  }) {
    return Score(
      id: id ?? this.id,
      name: name ?? this.name,
      display: display ?? this.display,
      description: description ?? this.description,
      groups: groups ?? this.groups,
      scoreFunction: scoreFunction,
      visibilityFunction: visibilityFunction,
    );
  }

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      id: json['id'] as int,
      name: json['name'] as String,
      display: json['display'] as String,
      description: json['description'] as String? ?? '',
      groups: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'display': display,
      'description': description,
      'groups': [],
    };
  }
}

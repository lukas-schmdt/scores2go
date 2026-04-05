import 'package:scores_2_go_2/model/score_group.dart';

class Score {
  final int id;
  final String name;
  final String display;
  final String description;
  final List<Group> groups;

  Score({
    required this.id,
    required this.name,
    required this.display,
    required this.description,
    required this.groups,
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
    );
  }

  /// ✅ Create a Score from a JSON map
  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      id: json['id'] as int,
      name: json['name'] as String,
      display: json['display'] as String,
      description: json['description'] as String? ?? '',
      groups: [],
    );
  }

  /// ✅ Convert a Score back to JSON
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

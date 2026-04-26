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
  /// Returns the asset path for the documentation in the given locale.
  /// Fall back to a default by returning a path regardless of locale.
  final String? Function(String locale)? doc;
  /// External website URL opened in a browser when the docs button is tapped.
  /// When set, the docs button launches the URL instead of showing the in-app
  /// markdown tab. When only [doc] is set, the markdown tab is shown instead.
  final String? docUrl;
  final String? author;
  final int? year;
  final int? popularity;
  final List<String> categories;

  Score({
    required this.id,
    required this.name,
    required this.display,
    required this.description,
    required this.groups,
    this.scoreFunction,
    this.visibilityFunction,
    this.doc,
    this.docUrl,
    this.author,
    this.year,
    this.popularity,
    this.categories = const [],
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
      doc: doc,
      author: author,
      year: year,
      popularity: popularity,
      categories: categories,
    );
  }

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      id: json['id'] as int,
      name: json['name'] as String,
      display: json['display'] as String,
      description: json['description'] as String? ?? '',
      groups: [],
      doc: json['doc'] != null ? (_) => json['doc'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'display': display,
      'description': description,
      'groups': [],
      'doc': doc,
    };
  }
}

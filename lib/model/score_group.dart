import 'package:scores_2_go/model/variable.dart' show Variable;

class Group {
  final int id;
  final String name;
  final String display;
  final String description;
  final List<Variable> items;
  Group({
    required this.id,
    required this.name,
    required this.display,
    required this.description,
    required this.items,
  });

  Group copyWith({
    int? id,
    String? name,
    String? display,
    String? description,
    List<Variable>? items,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      display: display ?? this.display,
      description: description ?? this.description,
      items: items ?? this.items,
    );
  }
}

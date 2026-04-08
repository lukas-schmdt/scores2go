import 'package:scores_2_go/model/variable.dart' show Variable;

class Group {
  final String name;
  final String display;
  final String description;
  final bool isVisible;
  final List<Variable> items;
  Group({
    required this.name,
    required this.display,
    required this.description,
    required this.isVisible,
    required this.items,
  });

  Group copyWith({
    String? name,
    String? display,
    String? description,
    bool? isVisible,
    List<Variable>? items,
  }) {
    return Group(
      name: name ?? this.name,
      display: display ?? this.display,
      description: description ?? this.description,
      isVisible: isVisible ?? this.isVisible,
      items: items ?? this.items,
    );
  }
}

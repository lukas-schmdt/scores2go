class ScoreCollection {
  const ScoreCollection({
    required this.id,
    required this.display,
    required this.scoreIds,
  });

  final int id;
  final String display;
  final List<int> scoreIds;

  ScoreCollection copyWith({int? id, String? display, List<int>? scoreIds}) {
    return ScoreCollection(
      id: id ?? this.id,
      display: display ?? this.display,
      scoreIds: scoreIds ?? this.scoreIds,
    );
  }
}

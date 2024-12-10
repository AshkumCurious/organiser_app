class Note {
  final int? id;
  final int categoryId;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note({
    this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

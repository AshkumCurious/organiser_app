class Category {
  final int? id;
  final String name;
  final int taskCount;

  Category({
    this.id,
    required this.name,
    this.taskCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'taskCount': taskCount,
    };
  }
}

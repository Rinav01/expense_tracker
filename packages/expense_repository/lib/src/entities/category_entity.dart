class CategoryEntity {
  String categoryId;
  String name;
  int totalExpenses;
  String icon;
  int color;

  CategoryEntity({
    required this.categoryId,
    required this.name,
    required this.totalExpenses,
    required this.icon,
    required this.color,
  });

  // Convert CategoryEntity to a Map to store in SQLite
  Map<String, Object?> toMap() {
    return {
      'categoryId': categoryId,
      'name': name,
      'totalExpenses': totalExpenses,
      'icon': icon,
      'color': color,
    };
  }

  // Convert Map from SQLite back to a CategoryEntity object
  static CategoryEntity fromMap(Map<String, dynamic> map) {
    return CategoryEntity(
      categoryId: map['categoryId'],
      name: map['name'],
      totalExpenses: map['totalExpenses'],
      icon: map['icon'],
      color: map['color'],
    );
  }
}

class Category {
  String categoryId;
  String name;
  int? totalExpenses;  // Nullable
  String icon;
  int? color;  // Nullable

  Category({
    required this.categoryId,
    required this.name,
    this.totalExpenses,  // Nullable
    required this.icon,
    this.color,  // Nullable
  });

  static final empty = Category(
    categoryId: '',
    name: '',
    totalExpenses: null,  // Nullable
    icon: '',
    color: null,  // Nullable
  );

  // Convert Category to a Map to store in SQLite
  Map<String, Object?> toMap() {
    return {
      'categoryId': categoryId,
      'name': name,
      'totalExpenses': totalExpenses,  // Nullable value
      'icon': icon,
      'color': color,  // Nullable value
    };
  }

  // Convert Map from SQLite back to a Category object
  static Category fromMap(Map<String, dynamic> map) {
    return Category(
      categoryId: map['categoryId'] ?? '',  // Default to empty string if null
      name: map['name'] ?? '',              // Default to empty string if null
      totalExpenses: map['totalExpenses'],  // Nullable
      icon: map['icon'] ?? '',              // Default to empty string if null
      color: map['color'],                  // Nullable
    );
  }
}

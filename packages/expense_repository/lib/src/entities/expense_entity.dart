import 'package:expense_repository/src/entities/entities.dart';
import 'package:expense_repository/src/models/models.dart';

class ExpenseEntity {
  String expenseId;
  Category category;
  DateTime date;
  int amount;

  ExpenseEntity({
    required this.expenseId,
    required this.category,
    required this.date,
    required this.amount,
  });

  // Convert ExpenseEntity to a Map to store in SQLite
  Map<String, Object?> toMap() {
    return {
      'expenseId': expenseId,
      'categoryId': category.categoryId, // Only save categoryId as it refers to a Category
      'date': date.toIso8601String(), // Store date as a string in ISO format
      'amount': amount,
    };
  }

  // Convert Map from SQLite back to an ExpenseEntity object
  static ExpenseEntity fromMap(Map<String, dynamic> map, Category category) {
    return ExpenseEntity(
      expenseId: map['expenseId'],
      category: category, // Fetch the Category object separately using categoryId
      date: DateTime.parse(map['date']), // Convert the string back to DateTime
      amount: map['amount'],
    );
  }
}

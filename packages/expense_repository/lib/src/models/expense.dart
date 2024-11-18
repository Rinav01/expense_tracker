import '../../expense_repository.dart';

class Expense {
  String expenseId;
  Category category;
  DateTime date;
  int amount;

  Expense({
    required this.expenseId,
    required this.category,
    required this.date,
    required this.amount,
  });

  static final empty = Expense(
    expenseId: '',
    category: Category.empty,
    date: DateTime.now(),
    amount: 0,
  );

  // Convert Expense to a Map to store in SQLite
  Map<String, Object?> toMap() {
    return {
      'expenseId': expenseId,
      'categoryId': category.categoryId, // Store only categoryId to relate with the Category table
      'date': date.toIso8601String(), // Convert DateTime to a string for SQLite storage
      'amount': amount,
    };
  }

  // Convert Map from SQLite back to an Expense object
  static Expense fromMap(Map<String, dynamic> map, Category category) {
    return Expense(
      expenseId: map['expenseId'],
      category: category, // Use the Category object passed as an argument
      date: DateTime.parse(map['date']), // Convert the string back to DateTime
      amount: map['amount'],
    );
  }
}

import 'package:expense_repository/expense_repository.dart';

abstract class ExpenseRepository {
  static var instance;


  // Create a new Category in the SQLite database
  Future<void> createCategory(Category category);

  // Get all Categories from the SQLite database
  Future<List<Category>> getCategories();

  // Create a new Expense in the SQLite database
  Future<void> createExpense(Expense expense);

  // Get all Expenses from the SQLite database
  Future<List<Expense>> getExpenses();
}

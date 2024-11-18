import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:expense_repository/expense_repository.dart'; // Your models and entities import

class SQLiteExpenseRepository implements ExpenseRepository {
  late Database _db;

  final String categoryTable = 'categories';
  final String expenseTable = 'expenses';

  SQLiteExpenseRepository() {
    _initializeDB();
  }

  // Initialize the SQLite database
  Future<void> _initializeDB() async {
    String path = join(await getDatabasesPath(), 'expense_tracker.db');
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Create tables in the SQLite database
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $categoryTable (
        categoryId TEXT PRIMARY KEY,
        name TEXT,
        totalExpenses INTEGER,
        icon TEXT,
        color INTEGER
      );
    ''');

    await db.execute('''
      CREATE TABLE $expenseTable (
        expenseId TEXT PRIMARY KEY,
        categoryId TEXT,
        date TEXT,
        amount INTEGER,
        FOREIGN KEY (categoryId) REFERENCES $categoryTable(categoryId)
      );
    ''');
  }

  @override
  Future<void> createCategory(Category category) async {
    try {
      await _db.insert(
        categoryTable,
        {
          'categoryId': category.categoryId,
          'name': category.name,
          'totalExpenses': category.totalExpenses,
          'icon': category.icon,
          'color': category.color,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategory() async {
    try {
      final List<Map<String, dynamic>> maps = await _db.query(categoryTable);
      return List.generate(maps.length, (i) {
        return Category(
          categoryId: maps[i]['categoryId'],
          name: maps[i]['name'],
          totalExpenses: maps[i]['totalExpenses'],
          icon: maps[i]['icon'],
          color: maps[i]['color'],
        );
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // Implement getCategories method required by ExpenseRepository
  @override
  Future<List<Category>> getCategories() async {
    try {
      final List<Map<String, dynamic>> maps = await _db.query(categoryTable);
      return List.generate(maps.length, (i) {
        return Category(
          categoryId: maps[i]['categoryId'],
          name: maps[i]['name'],
          totalExpenses: maps[i]['totalExpenses'],
          icon: maps[i]['icon'],
          color: maps[i]['color'],
        );
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> createExpense(Expense expense) async {
    try {
      await _db.insert(
        expenseTable,
        {
          'expenseId': expense.expenseId,
          'categoryId': expense.category.categoryId,
          'date': expense.date.toIso8601String(),  // Convert DateTime to String
          'amount': expense.amount,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Expense>> getExpenses() async {
    try {
      final List<Map<String, dynamic>> maps = await _db.query(expenseTable);
      return List.generate(maps.length, (i) {
        return Expense(
          expenseId: maps[i]['expenseId'],
          category: Category(
            categoryId: maps[i]['categoryId'],
            name: '', // You may want to join with category table if necessary
            totalExpenses: 0,
            icon: '',
            color: 0,
          ),
          date: DateTime.parse(maps[i]['date']),
          amount: maps[i]['amount'],
        );
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

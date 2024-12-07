import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:expense_repository/expense_repository.dart';

class ExpenseDatabase {
  static final ExpenseDatabase instance = ExpenseDatabase._init();

  static Database? _database;

  ExpenseDatabase._init();

  // Getter to ensure the database is initialized
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('expense_tracker.db');
    return _database!;
  }

  // Initialize the database with the given file path
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // Open the database and enable foreign keys
    final db = await openDatabase(path, version: 1, onCreate: _onCreate);
    await db.execute('PRAGMA foreign_keys = ON');
    return db;
  }

  // Initialize the database
  Future<void> initDatabase() async {
    await database;
  }

  // Create tables for categories and expenses
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categories (
        categoryId TEXT PRIMARY KEY,
        name TEXT,
        totalExpenses INTEGER,
        icon TEXT,
        color INTEGER
      );
    ''');

    await db.execute('''
      CREATE TABLE expenses (
        expenseId TEXT PRIMARY KEY,
        categoryId TEXT,
        date TEXT,
        amount INTEGER,
        FOREIGN KEY (categoryId) REFERENCES categories(categoryId)
      );
    ''');
  }

  // Insert an expense into the database
  Future<void> insertExpense(Expense expense) async {
    final db = await instance.database;

    await db.insert(
      'expenses',
      {
        'expenseId': expense.expenseId,
        'categoryId': expense.category.categoryId,
        'date': expense.date.toIso8601String(),
        'amount': expense.amount,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all expenses and their corresponding categories
  Future<List<Expense>> getExpenses() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> expenseMaps = await db.query('expenses');
    print("Fetched expenses: $expenseMaps");

    final List<Map<String, dynamic>> categoryMaps = await db.query('categories');
    print("Fetched categories: $categoryMaps");

    final Map<String, Category> categoryMap = {
      for (var category in categoryMaps)
        category['categoryId']: Category(
          categoryId: category['categoryId'],
          name: category['name'],
          totalExpenses: category['totalExpenses'],
          icon: category['icon'],
          color: Color(category['color']).value, // Convert integer back to Color
        ),
    };

    return List.generate(expenseMaps.length, (i) {
      final expenseMap = expenseMaps[i];
      final category = categoryMap[expenseMap['categoryId']] ??
          Category(
            categoryId: 'unknown',
            name: 'Unknown',
            totalExpenses: 0,
            icon: '',
            color: Colors.black.value, // Default color
          );

      return Expense(
        expenseId: expenseMap['expenseId'],
        category: category,
        date: DateTime.parse(expenseMap['date']),
        amount: expenseMap['amount'],
      );
    });
  }
}

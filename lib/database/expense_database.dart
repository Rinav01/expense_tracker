
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
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
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Method to initialize the database (newly added method)
  Future<void> initDatabase() async {
    await database; // Calls the getter to initialize the database if not already initialized
  }

  // Method to create tables (categories and expenses)
  Future<void> _onCreate(Database db, int version) async {
    // Create Categories table
    await db.execute(''' 
      CREATE TABLE categories (
        categoryId TEXT PRIMARY KEY,
        name TEXT,
        totalExpenses INTEGER,
        icon TEXT,
        color INTEGER
      );
    ''');

    // Create Expenses table
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

  // Insert sample data into the database for testing
  Future<void> insertSampleData() async {
    final db = await database;

    // Check if data already exists to avoid duplicate inserts
    if (await hasExpenses()) {
      print("Sample data already exists.");
      return;
    }

    // Insert a sample category
    await db.insert('categories', {
      'categoryId': 'cat1',
      'name': 'Food',
      'totalExpenses': 0,
      'icon': 'assets/images/food.png',
      'color': 0xFF0000FF, // Example color (blue)
    });

    // Insert a sample expense linked to the sample category
    await db.insert('expenses', {
      'expenseId': 'exp1',
      'categoryId': 'cat1',
      'date': DateTime.now().toIso8601String(),
      'amount': 100, // Example amount
    });

    print("Sample data inserted successfully.");
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

    // Fetch all expenses
    final List<Map<String, dynamic>> expenseMaps = await db.query('expenses');

    // Get all categories to fetch the related category details
    final List<Map<String, dynamic>> categoryMaps = await db.query('categories');

    // Map categoryId to Category for quick lookup
    final Map<String, Category> categoryMap = {
      for (var category in categoryMaps)
        category['categoryId']: Category(
          categoryId: category['categoryId'],
          name: category['name'],
          totalExpenses: category['totalExpenses'],
          icon: category['icon'],
          color: category['color'],
        )
    };

    // Generate the expenses list by associating each expense with the correct category
    return List.generate(expenseMaps.length, (i) {
      final expenseMap = expenseMaps[i];
      final category = categoryMap[expenseMap['categoryId']];

      return Expense(
        expenseId: expenseMap['expenseId'],
        category: category ?? Category(categoryId: expenseMap['categoryId'], name: '', totalExpenses: null, icon: '', color: null),
        date: DateTime.parse(expenseMap['date']),
        amount: expenseMap['amount'],
      );
    });
  }

  // Check if any expenses exist in the database (for debugging)
  Future<bool> hasExpenses() async {
    final db = await instance.database;
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM expenses'));
    return count != null && count > 0;
  }
}

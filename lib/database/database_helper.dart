import 'package:expense_repository/expense_repository.dart'; // Ensure Category is imported here
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Private constructor
  DatabaseHelper._privateConstructor();

  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // Getter for the database
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Initialize database
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'expense_tracker.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  // Create tables
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE expenses (
        id TEXT PRIMARY KEY,
        amount INTEGER,
        categoryId TEXT,
        date TEXT
      );
    ''');

    await db.execute(''' 
      CREATE TABLE categories (
        id TEXT PRIMARY KEY,
        name TEXT,
        color INTEGER,
        icon TEXT
      );
    ''');
  }

  // Upgrade tables if necessary
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // You can add logic to handle database version upgrades if needed.
  }

  // Insert a new expense
  Future<int> insertExpense(Map<String, dynamic> expense) async {
    final db = await instance.database;
    return await db.insert('expenses', expense);
  }

  // Fetch all expenses
  Future<List<Map<String, dynamic>>> fetchExpenses() async {
    final db = await instance.database;
    return await db.query('expenses');
  }

  // Insert a new category
  Future<int> insertCategory(Map<String, dynamic> category) async {
    final db = await instance.database;
    return await db.insert('categories', category);
  }

  // Fetch all categories and return them as Category objects
  Future<List<Category>> getCategories() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> categoryMaps = await db.query('categories');

    // Convert List<Map<String, dynamic>> to List<Category>
    return List.generate(categoryMaps.length, (i) {
      return Category.fromMap(categoryMaps[i]);
    });
  }
}

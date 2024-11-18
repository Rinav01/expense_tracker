import 'package:firebase_core/firebase_core.dart'; // Import Firebase core
import 'package:flutter/material.dart';
import 'package:expense_tracker1/app.dart';
import 'package:expense_tracker1/database/expense_database.dart'; // Import SQLite Database

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize SQLite database
  await ExpenseDatabase.instance.initDatabase(); // Calls the initDatabase method

  runApp(const MyApp());
}

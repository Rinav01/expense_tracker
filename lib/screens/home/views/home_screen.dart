import 'dart:math';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker1/screens/add_expense/views/add_expense.dart';
import 'package:expense_tracker1/screens/stats/stats.dart';

import '../../../database/expense_database.dart';
import 'main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  late Color selectedItem = Colors.blue;
  Color unselectedItem = Colors.grey;

  @override
  void initState() {
    super.initState();
    // Insert sample data for testing purposes
    ExpenseDatabase.instance.insertSampleData();
  }

  // Load expenses directly from SQLite via ExpenseDatabase
  Future<List<Expense>> _fetchExpenses() async {
    return await ExpenseDatabase.instance.getExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Expense>>(
      future: _fetchExpenses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Error loading expenses')),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('No expenses available')),
          );
        }

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            child: BottomNavigationBar(
              onTap: (value) => setState(() => index = value),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home,
                      color: index == 0 ? selectedItem : unselectedItem),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.graph_square_fill,
                      color: index == 1 ? selectedItem : unselectedItem),
                  label: 'Charts',
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddExpense()),
              );
            },
            shape: const CircleBorder(),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.tertiary,
                  ],
                  transform: const GradientRotation(pi / 4),
                ),
              ),
              child: const Icon(CupertinoIcons.add),
            ),
          ),
          body: index == 0
              ? MainScreen(snapshot.data!)
              : const StatScreen(),
        );
      },
    );
  }
}

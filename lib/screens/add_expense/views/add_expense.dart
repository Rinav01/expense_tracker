import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker1/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'category_creation.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  late Expense expense;
  bool isLoading = false;
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    expense = Expense.empty;
    expense.expenseId = const Uuid().v1();
    loadCategories(); // Load categories from SQLite
  }

  // Fetch categories from the database
  void loadCategories() async {
    final dbService = DatabaseHelper.instance; // Corrected instance usage
    categories = await dbService.getCategories(); // Corrected method call
    setState(() {});
  }

  // Save the expense to SQLite
  void saveExpense() async {
    setState(() {
      isLoading = true;
    });
    final dbService = DatabaseHelper.instance; // Corrected instance usage
    await dbService.insertExpense(expense.toMap()); // Passing expense as a map
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context, expense);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,  // Set the background color to black
        appBar: AppBar(
          backgroundColor: Colors.black,  // Set the app bar background color to black
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Add Expenses",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  controller: expenseController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white10,  // Keep the fill color subtle if you want contrast
                    prefixIcon: const Icon(
                      FontAwesomeIcons.dollarSign,
                      size: 16,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              TextFormField(
                controller: categoryController,
                textAlignVertical: TextAlignVertical.center,
                readOnly: true,
                onTap: () async {},
                decoration: InputDecoration(
                  filled: true,
                  fillColor: expense.category == Category.empty
                      ? Colors.white
                      : (expense.category.color != null
                      ? Color(int.parse(expense.category.color as String, radix: 16))
                      : Colors.transparent),
                  prefixIcon: expense.category == Category.empty
                      ? const Icon(
                    FontAwesomeIcons.list,
                    size: 16,
                    color: Colors.grey,
                  )
                      : Image.asset(
                    'assets/${expense.category.icon}.png',
                    scale: 2,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error, color: Colors.white);
                    },
                  ),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      var newCategory = await getCategoryCreation(context);
                      setState(() {
                        categories.insert(0, newCategory!);
                        expense.category = newCategory;
                        categoryController.text = newCategory.name;  // Update the category text
                      });
                    },
                    icon: const Icon(
                      FontAwesomeIcons.plus,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: 'Category',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, int i) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              expense.category = categories[i];
                              categoryController.text = categories[i].name;
                            });
                          },
                          leading: Image.asset(
                            'assets/${categories[i].icon}.png',  // Ensure icon name is correct
                            scale: 2,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error, color: Colors.black);
                            },
                          ),
                          title: Text(categories[i].name, style: const TextStyle(color: Colors.white)),
                          tileColor: categories[i].color != null
                              ? (categories[i].color is String
                              ? Color(int.parse(categories[i].color as String, radix: 16)) // If color is a hex string
                              : Color(categories[i].color as int)) // If color is already an int
                              : Colors.transparent, // Fallback color if it's null
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: dateController,
                textAlignVertical: TextAlignVertical.center,
                readOnly: true,
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: expense.date,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (newDate != null) {
                    setState(() {
                      dateController.text = DateFormat('dd/MM/yyyy').format(newDate);
                      expense.date = newDate;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    FontAwesomeIcons.clock,
                    size: 16,
                    color: Colors.grey,
                  ),
                  hintText: 'Date',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                height: kToolbarHeight,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : TextButton(
                  onPressed: () {
                    setState(() {
                      expense.amount = int.parse(expenseController.text);
                    });
                    saveExpense(); // Save the expense to SQLite
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

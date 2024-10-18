import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Add Expenses",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  controller: expenseController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white10,
                      prefixIcon: const Icon(
                        FontAwesomeIcons.rupeeSign,
                        color: Color.fromARGB(255, 243, 240, 240),
                        size: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              TextFormField(
                readOnly: true,
                onTap: () {},
                controller: categoryController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white10,
                    prefixIcon: const Icon(
                      FontAwesomeIcons.list,
                      color: Color.fromARGB(255, 243, 240, 240),
                      size: 16,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  backgroundColor:
                                      const Color.fromARGB(56, 64, 59, 59)
                                          .withOpacity(1),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Create a new Category",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white10,
                                            hintText: "Name",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        // readOnly: true,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white10,
                                            hintText: "Icon",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        // readOnly: true,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white10,
                                            hintText: "Color",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            )),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        icon: const Icon(
                          FontAwesomeIcons.plus,
                          color: Color.fromARGB(255, 243, 240, 240),
                          size: 16,
                        )),
                    hintText: "Category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
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
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)));
                  if (newDate != null) {
                    setState(() {
                      dateController.text =
                          DateFormat('dd/MM/yy').format(newDate);
                      selectedDate = newDate;
                    });
                  }
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white10,
                    prefixIcon: const Icon(
                      FontAwesomeIcons.calendar,
                      color: Color.fromARGB(255, 243, 240, 240),
                      size: 16,
                    ),
                    hintText: "Date",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: double.infinity,
                height: kToolbarHeight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

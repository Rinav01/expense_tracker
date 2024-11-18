import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:uuid/uuid.dart';

Future<Category?> getCategoryCreation(BuildContext context) async {
  List<String> myCategoriesIcons = [
    'entertainment',
    'food',
    'home',
    'pet',
    'shopping',
    'tech',
    'travel'
  ];

  return showDialog<Category?>(
    context: context,
    builder: (ctx) {
      bool isExpended = false;
      String iconSelected = '';
      Color categoryColor = Colors.white;
      TextEditingController categoryNameController = TextEditingController();
      bool isLoading = false;

      return StatefulBuilder(
        builder: (ctx, setState) {
          return AlertDialog(
            title: const Text('Create a Category'),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: categoryNameController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    onTap: () {
                      setState(() {
                        isExpended = !isExpended;
                      });
                    },
                    textAlignVertical: TextAlignVertical.center,
                    readOnly: true,
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      suffixIcon: const Icon(
                        CupertinoIcons.chevron_down,
                        size: 12,
                      ),
                      fillColor: Colors.white,
                      hintText: 'Icon',
                      border: OutlineInputBorder(
                        borderRadius: isExpended
                            ? const BorderRadius.vertical(top: Radius.circular(12))
                            : BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  if (isExpended)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                          ),
                          itemCount: myCategoriesIcons.length,
                          itemBuilder: (context, int i) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  iconSelected = myCategoriesIcons[i];
                                });
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: iconSelected == myCategoriesIcons[i]
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: AssetImage('assets/${myCategoriesIcons[i]}.png'),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  TextFormField(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx2) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ColorPicker(
                                  pickerColor: categoryColor,
                                  onColorChanged: (value) {
                                    setState(() {
                                      categoryColor = value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(ctx2);
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Save Color',
                                      style: TextStyle(fontSize: 22, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    textAlignVertical: TextAlignVertical.center,
                    readOnly: true,
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: categoryColor,
                      hintText: 'Color',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: kToolbarHeight,
                    child: isLoading
                        ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        : TextButton(
                      onPressed: () async {
                        // Show loading indicator
                        setState(() {
                          isLoading = true;
                        });

                        // Create a Category object
                        final category = Category(
                          categoryId: const Uuid().v1(),
                          name: categoryNameController.text,
                          icon: iconSelected,
                          color: categoryColor.value, totalExpenses: null,
                        );

                        // Insert category into SQLite
                        await ExpenseRepository.instance.insertCategory(category);

                        // Hide loading indicator and close the dialog
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pop(ctx, category); // Return the category after creation
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

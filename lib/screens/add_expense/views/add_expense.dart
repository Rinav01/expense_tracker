import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
  List<String> myCategoryIcons = [
    'entertainment',
    'food',
    'home',
    'pet',
    'shopping-bag',
    'tech',
    'travel',
  ];

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
                                bool isExpanded = false;
                                String iconSelected = '';
                                Color categoryColor = Colors.white10;
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        title: const Text(
                                          "Create a new Category",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        backgroundColor:
                                        const Color.fromARGB(56, 64, 59, 59)
                                            .withOpacity(1),
                                        content: SizedBox(
                                          width: MediaQuery.of(context).size.width,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  textAlignVertical:
                                                  TextAlignVertical.center,
                                                  decoration: InputDecoration(
                                                      isDense: true,
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
                                                  onTap: () {
                                                    setState(() {
                                                      isExpanded = !isExpanded;
                                                    });
                                                  },
                                                  textAlignVertical:
                                                  TextAlignVertical.center,
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      filled: true,
                                                      fillColor: Colors.white10,
                                                      suffixIcon: const Icon(
                                                        CupertinoIcons.chevron_down,
                                                        size: 12,
                                                      ),
                                                      hintText: "Icon",
                                                      border: OutlineInputBorder(
                                                        borderRadius: isExpanded
                                                            ? BorderRadius.vertical(
                                                            top: Radius.circular(
                                                                12))
                                                            : BorderRadius.circular(
                                                            12),
                                                      )),
                                                ),
                                                isExpanded
                                                    ? Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 200,
                                                  decoration: const BoxDecoration(
                                                      color: Colors.white10,
                                                      borderRadius:
                                                      BorderRadius.vertical(
                                                          bottom: Radius
                                                              .circular(
                                                              12))),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                    child: GridView.builder(
                                                        gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount:
                                                            3,
                                                            mainAxisSpacing:
                                                            5,
                                                            crossAxisSpacing:
                                                            5),
                                                        itemCount:
                                                        myCategoryIcons
                                                            .length,
                                                        itemBuilder:
                                                            (context, int i) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                iconSelected =
                                                                myCategoryIcons[
                                                                i];
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 50,
                                                              height: 50,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      width: 3,
                                                                      color: iconSelected ==
                                                                          myCategoryIcons[
                                                                          i]
                                                                          ? Colors
                                                                          .greenAccent
                                                                          : Colors
                                                                          .grey),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      12),
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/images/${myCategoryIcons[i]}.png'),
                                                                      fit: BoxFit
                                                                          .contain)),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                )
                                                    : Container(),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                TextFormField(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (ctx2) {
                                                          return AlertDialog(
                                                            content: Column(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              children: [
                                                                ColorPicker(
                                                                  pickerColor:
                                                                  Colors.blue,
                                                                  onColorChanged:
                                                                      (value) {
                                                                    setState(
                                                                          () {
                                                                        categoryColor =
                                                                            value;
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                  double.infinity,
                                                                  height: 50,
                                                                  child: TextButton(
                                                                    onPressed: () {
                                                                      Navigator.pop(
                                                                          ctx2);
                                                                    },
                                                                    style: TextButton
                                                                        .styleFrom(
                                                                        backgroundColor:
                                                                        Colors
                                                                            .white10,
                                                                        shape:
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                          BorderRadius.circular(12),
                                                                        )),
                                                                    child: const Text(
                                                                      "Save",
                                                                      style:
                                                                      TextStyle(
                                                                        fontSize: 22,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  textAlignVertical:
                                                  TextAlignVertical.center,
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    filled: true,
                                                    fillColor: categoryColor,
                                                    hintText: "Color",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: kToolbarHeight,
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // create category object and pop
                                                      Navigator.pop(context);
                                                    },
                                                    style: TextButton.styleFrom(
                                                        backgroundColor:
                                                        Colors.white10,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                        )),
                                                    child: const Text(
                                                      "Save",
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
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
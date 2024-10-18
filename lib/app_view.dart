import 'package:expense_tracker/screens/home/views/home_screen.dart';
import 'package:flutter/material.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      theme: ThemeData(
          colorScheme: ColorScheme.dark(
        surface: Colors.black, //interchange surface and onSurface
        onSurface: Colors.grey.shade100,
        primary: const Color(
            0xFFFFA500), // original color codes in order 0xFF00B2E7,0xFFE064F7,0xFFFF8D6C
        secondary: const Color(0xFFFF6347),
        tertiary: const Color(0xFFFF4500),
        outline: Colors.grey.shade200,
      )),
      home: const HomeScreen(),
    );
  }
}


// another combination for gradient colors: [
      //   Color(0xFF87CEFA),   Light Sky Blue
      //   Color(0xFFAFEEEE),   Pale Turquoise
      //   Color(0xFFFFB6C1),   Light Pink
      // ]
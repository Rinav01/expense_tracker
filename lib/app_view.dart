import 'package:expense_tracker1/authentication/login_page.dart';
import 'package:expense_tracker1/screens/home/views/home_screen.dart';
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
          surface: Colors.black, // Color for surfaces
          onSurface: Colors.grey.shade100, // Color for text/icons on surfaces
          primary: const Color(0xFFFFA500), // Primary color
          secondary: const Color(0xFFFF6347), // Secondary color
          tertiary: const Color(0xFFFF4500), // Tertiary color
          outline: Colors.grey.shade200, // Outline color
        ),
      ),
      home: const  Loginpage(),
    );
  }
}

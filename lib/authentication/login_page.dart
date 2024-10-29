import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker1/authentication/signup_page.dart';
import 'package:expense_tracker1/authentication/ui_helper.dart';
import 'package:expense_tracker1/screens/home/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:expense_tracker1/screens/home/views/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      UiHelper.customAlertDialog(context, "Please enter your email and password.");
      return;
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>   BlocProvider(
  create: (context) => GetExpensesBloc(FirebaseExpenseRepo())..add(GetExpenses()),
  child: HomeScreen(),
)));
    } on FirebaseAuthException catch (e) {
      UiHelper.customAlertDialog(context, e.message ?? "An unexpected error occurred.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface, // Set background color
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary, // Use primary color for app bar
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiHelper.customTextField(emailController, "Email", Icons.mail, false, context),
            const SizedBox(height: 16),
            UiHelper.customTextField(passwordController, "Password", Icons.password, true, context),
            const SizedBox(height: 30),
            UiHelper.customButton(() {
              login(emailController.text.trim(), passwordController.text.trim());
            }, "Login", context),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? ", style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupPage()),
                    );
                  },
                  child: const Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 2),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ForgotPassword()),
                );
              },
              child: const Text("Forgot Password?", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}

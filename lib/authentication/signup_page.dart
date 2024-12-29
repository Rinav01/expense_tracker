import 'package:expenses_tracker/authentication/ui_helper.dart';
import 'package:expenses_tracker/screens/home/views/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUp(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      UiHelper.customAlertDialog(context, "Please enter your email and password.");
      return; // Exit if validation fails
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UiHelper.customAlertDialog(context, "Account created successfully!");
      // Navigate to HomeScreen after a brief delay for user feedback
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      });
    } on FirebaseAuthException catch (e) {
      UiHelper.customAlertDialog(context, e.message ?? "An unexpected error occurred.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Page"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary, // AppBar color from color scheme
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25), // Add horizontal padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiHelper.customTextField(emailController, "Email", Icons.mail, false, context),
            const SizedBox(height: 16),
            UiHelper.customTextField(passwordController, "Password", Icons.password, true, context),
            const SizedBox(height: 30),
            UiHelper.customButton(() {
              signUp(emailController.text.trim(), passwordController.text.trim());
            }, "Sign Up", context),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the login page
              },
              child: const Text("Already have an account? Log in", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:expenses_tracker/authentication/signup_page.dart';
import 'package:expenses_tracker/authentication/ui_helper.dart';
import 'package:expenses_tracker/screens/home/views/home_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      if (mounted) {
        UiHelper.customAlertDialog(context, "Please enter your email and password.");
      }
      return;
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),  // Navigate directly to HomeScreen
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        UiHelper.customAlertDialog(context, e.message ?? "An unexpected error occurred.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
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
}//
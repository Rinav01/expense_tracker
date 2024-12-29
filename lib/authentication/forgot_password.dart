import 'package:expenses_tracker/authentication/ui_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();

  Future<void> forgotPassword(String email) async {
    if (email.isEmpty) {
      UiHelper.customAlertDialog(context, "Please enter a valid email address.");
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      UiHelper.customAlertDialog(context, "Password reset email sent. Check your inbox.");
      Navigator.pop(context); // Navigate back after sending the email
    } on FirebaseAuthException catch (e) {
      UiHelper.customAlertDialog(context, e.message ?? "An unexpected error occurred.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25), // Add horizontal padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiHelper.customTextField(emailController, "Email", Icons.mail, false, context),
            const SizedBox(height: 20),
            UiHelper.customButton(() {
              forgotPassword(emailController.text.trim()); // Use trim to avoid extra spaces
            }, "Reset Password", context),
          ],
        ),
      ),
    );
  }
}
import 'package:expense_tracker1/authentication/login_page.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase core
import 'package:flutter/material.dart';

import 'package:expense_tracker1/app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding is initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}


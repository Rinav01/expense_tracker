import 'package:flutter/material.dart';

class UiHelper {
  static Widget customTextField(
      TextEditingController controller,
      String text,
      IconData iconData,
      bool toHide,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: TextField(
        controller: controller,
        obscureText: toHide,
        style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface), // Text color on surfaces
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface
                  .withOpacity(0.5)), // Hint text color
          suffixIcon: Icon(iconData,
              color: Theme.of(context).colorScheme.onSurface), // Icon color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline), // Border color
          ),
        ),
      ),
    );
  }

  static Widget customButton(
      VoidCallback voidCallback, String text, BuildContext context) {
    return SizedBox(
      height: 50, // Height for better usability
      width: 300,
      child: ElevatedButton(
        onPressed: voidCallback,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary, // Primary color for button
        ),
        child: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface, // Use onSurface instead of onPrimary
              fontSize: 20), // Text color based on surface
        ),
      ),
    );
  }

  static void customAlertDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface), // Text color for dialog title
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "OK",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary), // Color for button text
              ),
            ),
          ],
        );
      },
    );
  }
}
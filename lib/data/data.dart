import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> transactionsData = [
  {
    'icon': const FaIcon(
      FontAwesomeIcons.burger,
      color: Color.fromARGB(255, 243, 240, 240),
    ),
    'color': Colors.red,
    'name': 'Food',
    'totalAmount': '- Rs 1000.00',
    'date': 'Today',
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.bagShopping, color:Color.fromARGB(255, 243, 240, 240)),
    'color': Colors.blue,
    'name': 'Shopping',
    'totalAmount': '- Rs 300.00',
    'date': 'Today',
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.heart, color: Color.fromARGB(255, 243, 240, 240)),
    'color': Colors.green,
    'name': 'Health',
    'totalAmount': '- Rs 450.00',
    'date': 'Yesterday',
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.car, color: Color.fromARGB(255, 236, 230, 230)),
    'color': Colors.yellow,
    'name': 'Travel',
    'totalAmount': '- Rs 300.00',
    'date': 'Today',
  },
];

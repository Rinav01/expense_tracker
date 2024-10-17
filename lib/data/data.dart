import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> transactionsData = [
  {
    'icon': const FaIcon(
      FontAwesomeIcons.burger,
      color: Colors.white,
    ),
    'color': Colors.red,
    'name': 'Food',
    'totalAmount': '- Rs 100.00',
    'date': 'Today',
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.bagShopping, color: Colors.white),
    'color': Colors.blue,
    'name': 'Shopping',
    'totalAmount': '- Rs 300.00',
    'date': 'Today',
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.heart, color: Colors.white),
    'color': Colors.green,
    'name': 'Health',
    'totalAmount': '- Rs 450.00',
    'date': 'Yesterday',
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.car, color: Colors.white),
    'color': Colors.yellow,
    'name': 'Travel',
    'totalAmount': '- Rs 300.00',
    'date': 'Today',
  },
];

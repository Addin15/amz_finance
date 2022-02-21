import 'package:amz_finance/models/budget.dart';
import 'package:amz_finance/pages/budgeting.dart';
import 'package:amz_finance/pages/expenses_dashboard.dart';
import 'package:amz_finance/pages/wallet_dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const ExpensesDashboard(),
    );
  }
}

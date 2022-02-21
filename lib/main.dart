import 'package:amz_finance/models/budget.dart';
import 'package:amz_finance/pages/budgeting.dart';
import 'package:amz_finance/pages/expenses_dashboard.dart';
import 'package:amz_finance/pages/transactions.dart';
import 'package:amz_finance/pages/wallet_dashboard.dart';
import 'package:amz_finance/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
        value: AuthService().user,
        initialData: null,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'Roboto',
            ),
            home: Wrapper(),
          );
        });
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);

    if (user == null) {
      return SignIn();
    } else {
      return WalletDashboard();
    }
  }
}

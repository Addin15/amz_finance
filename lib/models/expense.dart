import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  String? name;
  double? amount;
  Timestamp? timestamp;
  String? category;
  String? account;

  Expense({
    this.name,
    this.amount,
    this.timestamp,
    this.category,
    this.account,
  });

  Expense.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        amount = json['amount'],
        timestamp = json['timestamp'],
        category = json['category'],
        account = json['account'];
}

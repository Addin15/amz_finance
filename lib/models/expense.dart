import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  String? description;
  double? amount;
  Timestamp? timestamp;
  String? category;
  String? account;

  Expense({
    this.description,
    this.amount,
    this.timestamp,
    this.category,
    this.account,
  });

  Expense.fromJson(Map<String, dynamic> json)
      : description = json['name'],
        amount = json['amount'].toDouble(),
        timestamp = json['timestamp'],
        category = json['category'],
        account = json['account'];
}

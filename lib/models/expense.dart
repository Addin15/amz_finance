import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  String? id;
  String? description;
  double? amount;
  Timestamp? timestamp;
  String? category;
  String? account;

  Expense({
    this.id,
    this.description,
    this.amount,
    this.timestamp,
    this.category,
    this.account,
  });

  Expense.fromJson(String transactionId, Map<String, dynamic> json)
      : id = transactionId,
        description = json['description'],
        amount = json['amount'].toDouble(),
        timestamp = json['date'],
        category = json['category'],
        account = json['acc'];
}

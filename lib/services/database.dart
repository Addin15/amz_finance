import 'package:amz_finance/models/bank.dart';
import 'package:amz_finance/models/budget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream user's bank accounts
  Stream<List<Bank>> streamAccounts(String uid) {
    return _db
        .collection('accounts')
        .doc(uid)
        .collection('bankaccounts')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Bank.fromSnapshot(doc.id, doc.data()))
            .toList());
  }

  // stream budgets
  Stream<List<Budget>> streamBudgets(String uid) {
    return _db.collection('users').doc(uid).snapshots().map((doc) =>
        (doc.get('budgets') as List<dynamic>)
            .map((e) => Budget.fromSnapshot(e))
            .toList());
  }

  // add budget
  Future<void> addBudget(Budget budget, String uid) async {
    await _db.collection('users').doc(uid).update({
      'budgets': FieldValue.arrayUnion([
        {
          'name': budget.name,
          'budget': budget.allocation,
        }
      ]),
    });
  }

  // update budget
  Future<void> updateBudget(List<Budget> budgets, String uid) async {
    await _db.collection('users').doc(uid).update({
      'budgets': budgets.map((budget) => Budget.toMap(budget)).toList(),
    });
  }
}

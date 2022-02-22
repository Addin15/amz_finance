import 'package:amz_finance/models/bank.dart';
import 'package:amz_finance/models/budget.dart';
import 'package:amz_finance/models/expense.dart';
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

  // stream transactions
  Stream<List<Expense>> streamExpenses(String uid) {
    return _db
        .collection('transactions')
        .doc(uid)
        .collection('usertransactions')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Expense.fromJson(doc.id, doc.data()))
            .toList());
  }

  Stream<List<Expense>> streamExpensesByBank(String uid, String account) {
    return _db
        .collection('transactions')
        .doc(uid)
        .collection('usertransactions')
        .where('acc', isEqualTo: account)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Expense.fromJson(doc.id, doc.data()))
            .toList());
  }

  Future<List<Expense>> getExpenses(String uid, String category) async {
    try {
      print(category);
      QuerySnapshot<Map<String, dynamic>> data = await _db
          .collection('transactions')
          .doc(uid)
          .collection('usertransactions')
          .where('category', isEqualTo: category)
          .get();

      return data.docs
          .map((doc) => Expense.fromJson(doc.id, doc.data()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> addBank(Bank bank, String uid) async {
    try {
      await _db
          .collection('accounts')
          .doc(uid)
          .collection('bankaccounts')
          .doc(bank.accountNumber)
          .set({
        'accountType': bank.accountType,
        'balance': bank.balance,
        'bank': bank.bank,
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> categorizeExpense(
      String uid, String transactionId, String category) async {
    try {
      await _db
          .collection('transactions')
          .doc(uid)
          .collection('usertransactions')
          .doc(transactionId)
          .update({
        'category': category,
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addTransaction(String uid, Expense expense) async {
    try {
      await _db
          .collection('transactions')
          .doc(uid)
          .collection('usertransactions')
          .doc(expense.timestamp!.millisecondsSinceEpoch.toString())
          .set({
        'acc': expense.account,
        'amount': expense.amount,
        'category': expense.category,
        'date': expense.timestamp,
        'description': expense.description,
      });

      await _db
          .collection('accounts')
          .doc(uid)
          .collection('bankaccounts')
          .doc(expense.account)
          .update({
        'balance':
            FieldValue.increment(num.parse((expense.amount! * -1).toString())),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> getUserName(String uid) async {
    return await _db
        .collection('users')
        .doc(uid)
        .get()
        .then((user) => user.get('name'));
  }
}

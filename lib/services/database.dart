import 'package:amz_finance/models/bank.dart';
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
}

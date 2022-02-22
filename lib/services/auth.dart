import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.userChanges();

  get userId => _auth.currentUser!.uid;

  Future<dynamic> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(value.user!.uid)
            .set({
          'name': name,
          'budgets': [],
        });
        return value;
      });
      User? user = userCredential.user;
      return user;
    } catch (e) {
      return null;
    }
  }

  void signOut() {
    try {
      _auth.signOut();
    } catch (e) {
      e.hashCode;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static Future<String> loginAccount(
      {required String email, required String password}) async {
    String status = "";
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      status = 'success';
    } on FirebaseAuthException catch (e) {
      status = e.code;
      if (e.code == 'user-not-found') {
        status = 'Invalid Credentials';
      }
      if (e.code == 'wrong-password') {
        status = 'Incorrect password';
      }
    }
    return status;
  }

  static Future<String> createAccount(dynamic object) async {
    String status = "";
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: object.email, password: object.password);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.user!.uid)
          .set(
            object.toFirestore(),
          );
      status = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        status = 'Email already used';
      }
      if (e.code == "weak-password") {
        status = 'Please enter a secure password';
      }
      if (e.code == 'null-user-credential') {
        status =
            'An error occured while creating your account. Please try again';
      }
    }
    return status;
  }

  static Stream<User?> authChange() {
    return FirebaseAuth.instance.authStateChanges();
  }

  static String uid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  static Future<Map<String, dynamic>?> getClientData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final docs =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = docs.data();
    data?.addAll({'uid': uid});
    return data;
  }
}

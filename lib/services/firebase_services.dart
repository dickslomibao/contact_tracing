import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FirebaseService {
  static final auth = FirebaseAuth.instance;
  static final store = FirebaseFirestore.instance;
  static const String userPath = "users";
  static Future<String> loginAccount(
      {required String email, required String password}) async {
    String status = "";
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
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
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: object.email, password: object.password);

      await store
          .collection(userPath)
          .doc(user.user!.uid)
          .set(object.toFirestore());
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
    return auth.authStateChanges();
  }

  static String uid() {
    if (auth.currentUser == null) {
      return "1";
    }
    return auth.currentUser!.uid;
  }

  static Future<Map<String, dynamic>?> getClientData() async {
    final docs = await store.collection(userPath).doc(uid()).get();
    final data = docs.data();
    data?.addAll({'uid': uid()});
    return data;
  }

  static Future<List<Map<String, dynamic>>> getLogs(String date) async {
    List<Map<String, dynamic>> data = [];
    final temp = await store
        .collection('logs')
        .where(
          'date',
          isEqualTo: date,
        )
        .get();

    for (var item in temp.docs) {
      var tempItem = item.data();
      String clientFullName = "";
      final clientInfo =
          await store.collection(userPath).doc(tempItem['user_uid']).get();
      clientFullName = clientInfo.data()!['firstname'] +
          " " +
          clientInfo.data()!['middlename'] +
          " " +
          clientInfo.data()!['lastname'];
      tempItem.addAll({'client_name': clientFullName});
      data.add(tempItem);
    }

    return data;
  }

  static Future<void> logout() async {
    await auth.signOut();
  }

  static Future<void> updateIformation(Map<String, dynamic> data) async {
    await store.collection(userPath).doc(uid()).update(data);
  }

  static Future<bool> uidIsValid(String uid) async {
    final data = await store.collection(userPath).doc(uid).get();
    return data.exists;
  }

  static Future<void> storeLogs(String user) async {
    await FirebaseFirestore.instance.collection('logs').add(
      {
        'user_uid': user,
        'establishment_uid': uid(),
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      },
    );
  }
}

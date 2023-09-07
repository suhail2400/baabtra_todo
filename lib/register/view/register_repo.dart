import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpRepo {
  Future<void> createUser(String name, String email, String phone,
      String password, BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final CollectionReference userDetails =
        FirebaseFirestore.instance.collection('userDetails');
    try {
      final UserCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userDetails.doc(UserCredential.user!.uid).set({
        'userId': auth.currentUser!.uid,
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code)));
    }
  }
}

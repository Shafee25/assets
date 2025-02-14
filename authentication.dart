import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthServices {
  //    For storing data in cloud firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //    For authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

// For SignUp
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name
  }) async {
    String res = "Some error occured";
    try {
      //  For registering user in firebase auth with email and password
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      // For adding user to our cloud firestore
      await _firestore.collection("users").doc(credential.user!.uid).set({
        'name':name,
        'email':email,
        'uid': credential.user!.uid,
      });

      res = "success";
    }

    catch (e) {
      print(e.toString());
      res = e.toString();
    }
    return res;
  }

//   For login
  Future<String> loginUser({
    required email,
    required password
  })  async {
    String res = "Some error occurred";
    try{
      await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      res = "success";
    } catch (e) {
      print(e.toString());
      res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../widgets/show_message.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

void updateUserData(name,email,phone) async{

  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString('name', name);
  prefs.setString('email', email);

  _auth.currentUser?.updateDisplayName(name);
  _auth.currentUser?.updateEmail(email);
  _auth.currentUser?.updatePhoneNumber(phone);
  showToast("Profile Updated Successfully");
}


void updateName(name){
  _auth.currentUser?.updateDisplayName(name);
  showToast("Your Name is Successfully Updated as $name");
}

void updateEmail(email){
  _auth.currentUser?.updateEmail(email);
  showToast("Your Email is Successfully Updated as $email");
}

void updatePhone(phone){
  _auth.currentUser?.updatePhoneNumber(phone);
  showToast("Your Phone is Successfully Updated as $phone");
}

void updatePassword(password){
  _auth.currentUser?.updatePhoneNumber(password);
  showToast("Your Password is Successfully Updated");
}



void moveToHomePage(context) {
  Navigator.pushNamedAndRemoveUntil(context, "/main", (route) => false);
}

Future<String?> signUpWithEmailAndPassword(String email, String password, String name,context) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;

    await user?.updateDisplayName(name);
    showToast(" Registered Successfully");
    return 'true';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      showToast("The password provided is too weak.");
    } else if (e.code == 'email-already-in-use') {
      showToast("The account already exists for that email.");
    }
  } catch (e) {
    showToast("An error occurred while signing up.");
  }
  return null;
}


Future<String?> signInWithEmailAndPassword(String email, String password) async {
  try {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // User? user = userCredential.user;
    showToast("LoggedIn Successfully");
    return 'true';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      showToast("No user found for that email.");
    } else if (e.code == 'wrong-password') {
      showToast("Wrong password provided for that user.");
    }
  } catch (e) {
    showToast("An error occurred while signing in.");
  }
  return null;
}

void addUserData(name,email,gender,phone) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString('name', name);
  prefs.setString('email', email);

  final user = FirebaseAuth.instance.currentUser;
  final userId = user?.uid;
  if (kDebugMode) {
    print(userId);
  }

  final userRef = FirebaseFirestore.instance.collection('users');

  final userData = {
    'name': name,
    'email': email,
    'gender': gender,
    'phone': phone,
  };

  await userRef.doc(userId).set(userData);
}

bool checkLoggedIn(){
  final user = FirebaseAuth.instance.currentUser;

  if(user != null){
    return true;
  }
  else{
    return false;
  }
}

void sendResetPasswordLink(email) async {
  await _auth.sendPasswordResetEmail(email: email);
  showToast('Password reset link sent');
}

void logOut() async {
  await _auth.signOut();
}





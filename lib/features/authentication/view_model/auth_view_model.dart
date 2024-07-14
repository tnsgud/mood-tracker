import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/core/messages/error.dart';

class AuthViewModel extends Notifier<User?> {
  final emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]+");

  bool _validate({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    if (email == '' || password == '') {
      ScaffoldMessenger.of(context).showSnackBar(ErrorMessages.empty.snackBar);
      return false;
    }

    if (!emailValid.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        ErrorMessages.invalidEmail.snackBar,
      );
      return false;
    }

    return true;
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final valid = _validate(
      email: email,
      password: password,
      context: context,
    );

    if (!valid) return;

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      state = credential.user;

      if (context.mounted) {
        context.go('/feeds');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            ErrorMessages.invalidLoginCredentials.snackBar,
          );
        }
        return;
      }
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final valid = _validate(
      email: email,
      password: password,
      context: context,
    );

    if (!valid) return;

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final collection =
          FirebaseFirestore.instance.collection(credential.user!.email!);

      collection.add({'test': 'hello world'});

      if (context.mounted) {
        context.go('/feeds');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          ErrorMessages.weakPassword.snackBar,
        );
        return;
      }

      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          ErrorMessages.emailAlreadyInUse.snackBar,
        );
        return;
      }
    }
  }

  @override
  User? build() {
    return null;
  }
}

final authProvider = NotifierProvider<AuthViewModel, User?>(AuthViewModel.new);

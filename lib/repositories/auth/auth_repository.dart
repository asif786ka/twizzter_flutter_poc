import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/services.dart';
import 'package:twizzter/config/paths.dart';
import 'package:twizzter/models/failure_model.dart';
import 'package:twizzter/repositories/repositories.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepository({
    required FirebaseFirestore firebaseFirestore,
    required auth.FirebaseAuth firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore,
        _firebaseAuth = firebaseAuth;

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<auth.User?> signUpWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential?.user;
      _firebaseFirestore.collection(Paths.users).doc(user?.uid).set({
        'username': username,
        'email': email,
        'followers': 0,
        'following': 0,
      });
      return user;
    } on auth.FirebaseAuthException catch (err) {
      throw Failure(code: err.code, message: err.message!);
    } on PlatformException catch (err) {
      throw Failure(code: err.code, message: err.message!);
    }
  }

  @override
  Future<auth.User?> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on auth.FirebaseAuthException catch (err) {
      throw Failure(code: err.code, message: err.message!);
    } on PlatformException catch (err) {
      throw Failure(code: err.code, message: err.message!);
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}

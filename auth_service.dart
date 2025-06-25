import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final key = encrypt.Key.fromLength(32);
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromLength(32)));

  Future<User?> signIn(String email, String password, String role) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      await _db.collection('users').doc(cred.user!.uid).set({
        'email': encrypter.encrypt(email, iv: iv).base64,
        'role': role,
        'lastLogin': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      return cred.user;
    } catch (e) {
      print('Sign-in error: $e');
      return null;
    }
  }

  Future<bool> verifyOtp(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('<https://your-cloud-run-url/verify-otp>'),
        body: jsonEncode({'email': email, 'otp': otp}),
        headers: {'Content-Type': 'application/json'},
      );
      return response.statusCode == 200;
    } catch (e) {
      print('OTP verification error: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

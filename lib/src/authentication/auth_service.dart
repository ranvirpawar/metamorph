// auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharedPreferences _prefs;

  final Rx<User?> user = Rx<User?>(null);
  final RxBool isLoading = false.obs;
  final RxString verificationId = ''.obs;

  AuthService(this._prefs) {
    _auth.authStateChanges().listen((User? user) {
      this.user.value = user;
    });
  }

  // Send OTP
  Future<void> sendOTP(String phoneNumber) async {
    try {
      isLoading.value = true;
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          throw Exception(e.message);
        },
        codeSent: (String verId, int? resendToken) {
          verificationId.value = verId;
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId;
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Verify OTP
  Future<void> verifyOTP(String otp) async {
    try {
      isLoading.value = true;
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        await _saveUserSession(userCredential.user!);
      }
    } catch (e) {
      throw Exception('Failed to verify OTP: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Save user session
  Future<void> _saveUserSession(User user) async {
    await _prefs.setString('uid', user.uid);
    await _prefs.setString('phoneNumber', user.phoneNumber ?? '');
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
    await _prefs.clear();
  }

  // Check if user is logged in
  bool get isLoggedIn => _auth.currentUser != null;

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;
}
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  final StreamController<bool> _onAuthStateChange =
      StreamController.broadcast();

  Stream<bool> get onAuthStateChange => _onAuthStateChange.stream;

  bool get isSignedIn => _auth.currentUser != null;

  User? get currentUser => _auth.currentUser;

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await _auth.signInWithCredential(authCredential);
        if (isSignedIn) {
          _onAuthStateChange.add(true);
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  signInWithEmail(String email, String password) {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => null);

    if (isSignedIn) {
      _onAuthStateChange.add(true);
    }
  }

  signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    if (!isSignedIn) {
      _onAuthStateChange.add(false);
    }
  }

  static String verificationCode = '';

  newUserMail(String email, String password) {
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => null);
    if (isSignedIn) {
      _onAuthStateChange.add(true);
    }
  }

  newUserPhone(String phone) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        if (isSignedIn) {
          _onAuthStateChange.add(true);
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }

        // Handle other errors
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        verificationCode = verificationId;
      },
    );
  }

  signWithOtp(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationCode, smsCode: otp);
    await _auth.signInWithCredential(credential);
    if (isSignedIn) {
      _onAuthStateChange.add(true);
    }
  }
}

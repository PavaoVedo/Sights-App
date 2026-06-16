import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthClient {
  Future<UserCredential> signIn(final String email, final String password) async {
    final userCredentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredentials;
  }

  Future<UserCredential> signUp(final String email, final String password) async {
    final userCredentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredentials;
  }

  User? getCurrentUser() => FirebaseAuth.instance.currentUser;

  Future<void> signOut() => FirebaseAuth.instance.signOut();

  Future<void> deleteAccount() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }
}
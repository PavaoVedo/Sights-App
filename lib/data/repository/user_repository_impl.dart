import 'package:firebase_auth/firebase_auth.dart';
import 'package:sights_app/data/client/firebase_auth_client.dart';
import 'package:sights_app/domain/model/result.dart';
import 'package:sights_app/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuthClient firebaseClient;

  UserRepositoryImpl(this.firebaseClient);

  @override
  Future<Result<User>> signIn(String email, String password) async {
    try {
      final userCredential = await firebaseClient.signIn(email, password);
      return Result.ok(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return Result.error(Exception("Invalid email or password"));
      }
      return Result.error(Exception("Authentication internal error."));
    } catch (e) {
      return Result.error(Exception("There was an error."));
    }
  }

  @override
  Future<Result<User>> signUp(String email, String password) async {
    try {
      final userCredential = await firebaseClient.signUp(email, password);
      return Result.ok(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return Result.error(Exception("An account already exists for that email."));
        case 'invalid-email':
          return Result.error(Exception("The email address is invalid."));
        case 'weak-password':
          return Result.error(Exception("The password is too weak."));
        default:
          return Result.error(Exception("Authentication internal error."));
      }
    } catch (e) {
      return Result.error(Exception("There was an error."));
    }
  }

  @override
  User? getCurrentUser() => firebaseClient.getCurrentUser();

  @override
  Future<void> signOut() => firebaseClient.signOut();

  @override
  Future<Result<bool>> deactivateAccount() async {
    try {
      await firebaseClient.deleteAccount();
      return Result.ok(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        return Result.error(
          Exception("Please sign in again before deactivating your account."),
        );
      }
      return Result.error(Exception("Could not deactivate the account."));
    } catch (e) {
      return Result.error(Exception("There was an error."));
    }
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sights_app/domain/model/result.dart';

abstract interface class UserRepository {
  Future<Result<User>> signIn(final String email, final String password);

  Future<Result<User>> signUp(final String email, final String password);
}
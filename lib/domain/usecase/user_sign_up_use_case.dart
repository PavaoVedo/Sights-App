import 'package:firebase_auth/firebase_auth.dart';
import 'package:sights_app/domain/model/result.dart';
import 'package:sights_app/domain/repository/user_repository.dart';

class UserSignUpUseCase {
  final UserRepository repository;

  UserSignUpUseCase(this.repository);

  Future<Result<User>> call(final String email, final String password) {
    return repository.signUp(email, password);
  }
}
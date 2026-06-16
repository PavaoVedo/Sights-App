import 'package:firebase_auth/firebase_auth.dart';
import 'package:sights_app/domain/repository/user_repository.dart';

class GetCurrentUserUseCase {
  final UserRepository repository;

  GetCurrentUserUseCase(this.repository);

  User? call() => repository.getCurrentUser();
}
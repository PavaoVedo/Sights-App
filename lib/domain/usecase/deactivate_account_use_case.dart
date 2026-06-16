import 'package:sights_app/domain/model/result.dart';
import 'package:sights_app/domain/repository/user_repository.dart';

class DeactivateAccountUseCase {
  final UserRepository repository;

  DeactivateAccountUseCase(this.repository);

  Future<Result<bool>> call() => repository.deactivateAccount();
}
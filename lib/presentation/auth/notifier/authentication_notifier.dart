import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sights_app/di.dart';
import 'package:sights_app/domain/model/result.dart';
import 'package:sights_app/domain/usecase/user_sign_in_use_case.dart';
import 'package:sights_app/domain/usecase/user_sign_up_use_case.dart';
import 'package:sights_app/presentation/auth/notifier/state/authentication_state.dart';

class AuthenticationNotifier extends Notifier<AuthenticationState> {
  late UserSignInUseCase _signInUseCase;
  late UserSignUpUseCase _signUpUseCase;

  @override
  AuthenticationState build() {
    _signInUseCase = ref.watch(userSignInUseCaseProvider);
    _signUpUseCase = ref.watch(userSignUpUseCaseProvider);
    return EmptyState();
  }

  void signIn(final String email, final String password) async {
    state = LoadingState();

    final result = await _signInUseCase(email, password);

    switch (result) {
      case Ok<User>():
        state = AuthenticatedState(result.value);
      case Error():
        state = ErrorState(result.error.toString());
    }
  }

  void signUp(final String email, final String password) async {
    state = LoadingState();

    final result = await _signUpUseCase(email, password);

    switch (result) {
      case Ok<User>():
        state = AuthenticatedState(result.value);
      case Error():
        state = ErrorState(result.error.toString());
    }
  }
}
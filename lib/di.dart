import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sights_app/data/client/firebase_auth_client.dart';
import 'package:sights_app/data/client/sight_api_client.dart';
import 'package:sights_app/data/repository/sight_repository_impl.dart';
import 'package:sights_app/data/repository/user_repository_impl.dart';
import 'package:sights_app/domain/repository/sight_repository.dart';
import 'package:sights_app/domain/repository/user_repository.dart';
import 'package:sights_app/domain/usecase/get_all_sights_use_case.dart';
import 'package:sights_app/domain/usecase/user_sign_in_use_case.dart';
import 'package:sights_app/domain/usecase/user_sign_up_use_case.dart';
import 'package:sights_app/presentation/auth/notifier/authentication_notifier.dart';
import 'package:sights_app/presentation/auth/notifier/state/authentication_state.dart';
import 'package:sights_app/presentation/sights/notifier/sight_list_notifier.dart';
import 'package:sights_app/presentation/sights/notifier/state/sight_list_state.dart';

// *************** CLIENT *************** //
final firebaseAuthClientProvider = Provider<FirebaseAuthClient>((_) => FirebaseAuthClient());

final dioProvider = Provider<Dio>((_) => Dio());
final sightApiClientProvider = Provider<SightApiClient>((ref) => SightApiClient(ref.watch(dioProvider)));

// *************** REPOSITORY *************** //
final userRepositoryProvider = Provider<UserRepository>(
      (ref) => UserRepositoryImpl(ref.watch(firebaseAuthClientProvider)),
);

final sightRepositoryProvider = Provider<SightRepository>(
      (ref) => SightRepositoryImpl(ref.watch(sightApiClientProvider)),
);

// *************** USE CASE *************** //
final userSignInUseCaseProvider = Provider<UserSignInUseCase>(
      (ref) => UserSignInUseCase(ref.watch(userRepositoryProvider)),
);

final userSignUpUseCaseProvider = Provider<UserSignUpUseCase>(
      (ref) => UserSignUpUseCase(ref.watch(userRepositoryProvider)),
);

final getAllSightsUseCaseProvider = Provider<GetAllSightsUseCase>(
      (ref) => GetAllSightsUseCase(ref.watch(sightRepositoryProvider)),
);

// *************** NOTIFIER *************** //
final authenticationNotifierProvider = NotifierProvider<AuthenticationNotifier, AuthenticationState>(
      () => AuthenticationNotifier(),
);

final sightListNotifierProvider = NotifierProvider<SightListNotifier, SightListState>(
      () => SightListNotifier(),
);
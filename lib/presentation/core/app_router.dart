import 'package:flutter/material.dart';
import 'package:sights_app/domain/model/sight.dart';
import 'package:sights_app/presentation/auth/screen/sign_in_screen.dart';
import 'package:sights_app/presentation/auth/screen/sign_up_screen.dart';
import 'package:sights_app/presentation/auth/screen/splash_screen.dart';
import 'package:sights_app/presentation/sights/screen/main_menu_screen.dart';
import 'package:sights_app/presentation/sights/screen/sight_details_screen.dart';

class AppRouter {
  static const String splashScreen = '/';
  static const String signInScreen = '/signIn';
  static const String signUpScreen = '/signUp';
  static const String mainMenuScreen = '/mainMenu';
  static const String sightDetailsScreen = '/sightDetails';

  AppRouter._();

  static Route<dynamic> generateRoute(final RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case signInScreen:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case mainMenuScreen:
        return MaterialPageRoute(builder: (_) => const MainMenuScreen());
      case sightDetailsScreen:
        final sight = settings.arguments as Sight;
        return MaterialPageRoute(builder: (_) => SightDetailsScreen(sight: sight));
      default:
        throw Exception("Route not found...");
    }
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sights_app/di.dart';
import 'package:sights_app/presentation/auth/notifier/state/authentication_state.dart';
import 'package:sights_app/presentation/auth/screen/sign_in_screen.dart';
import 'package:sights_app/presentation/auth/widget/custom_text_field.dart';
import 'package:sights_app/presentation/core/app_router.dart';
import 'package:sights_app/presentation/core/style/extensions.dart';
import 'package:sights_app/presentation/core/widget/custom_action_button.dart';
import 'package:sights_app/presentation/core/widget/custom_app_bar.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final RegExp _emailRegExp =
  RegExp(r"^[a-zA-Z0-9.!#$%&'*+\-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authenticationNotifierProvider);

    ref.listen(authenticationNotifierProvider, (_, currentState) {
      // Only the route currently on top should react — prevents the
      // Sign In screen underneath from also navigating on the same state.
      if (ModalRoute.of(context)?.isCurrent != true) return;

      if (currentState is AuthenticatedState) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRouter.mainMenuScreen,
              (route) => false,
        );
      }

      if (currentState is ErrorState) {
        ErrorSnackBar.show(
          context,
          currentState.errorMessage.replaceFirst('Exception: ', ''),
        );
      }
    });

    return Scaffold(
      appBar: const CustomAppBar(title: "Register"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset("assets/images/sign_in_image.png", height: 200),
                const SizedBox(height: 20),
                Text(
                  "Please create an account to continue.",
                  style: context.textSubtitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  placeholder: "Email",
                  controller: _emailController,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  placeholder: "Password",
                  controller: _passwordController,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  placeholder: "Confirm password",
                  controller: _confirmPasswordController,
                  validator: _validateConfirmPassword,
                ),
                const SizedBox(height: 30),
                CustomActionButton(
                  label: "Sign up",
                  isLoading: state is LoadingState,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref.read(authenticationNotifierProvider.notifier).signUp(
                        _emailController.text.trim(),
                        _passwordController.text,
                      );
                    }
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: context.textSubtitle,
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "Sign in.",
                        style: context.textSubtitle.copyWith(color: context.colorLink),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    if (!_emailRegExp.hasMatch(value.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Za-z]').hasMatch(value) || !RegExp(r'\d').hasMatch(value)) {
      return 'Password must contain both letters and numbers';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
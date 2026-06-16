import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sights_app/di.dart';
import 'package:sights_app/domain/model/result.dart';
import 'package:sights_app/presentation/auth/screen/sign_in_screen.dart';
import 'package:sights_app/presentation/core/app_router.dart';
import 'package:sights_app/presentation/core/style/extensions.dart';
import 'package:sights_app/presentation/core/widget/custom_action_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(getCurrentUserUseCaseProvider)();
    final email = user?.email ?? 'Unknown';
    final displayName = user?.displayName;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My profile', style: context.textTitle),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: context.colorGradientBegin.withOpacity(0.15),
                        backgroundImage:
                        user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
                        child: user?.photoURL == null
                            ? Icon(Icons.person_rounded, size: 60, color: context.colorGradientEnd)
                            : null,
                      ),
                      const SizedBox(height: 20),
                      if (displayName != null && displayName.isNotEmpty) ...[
                        Text(displayName, style: context.textSubtitle),
                        const SizedBox(height: 4),
                        Text(email, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                      ] else
                        Text(email, style: context.textSubtitle),
                    ],
                  ),
                ),
              ),
              _GradientOutlineButton(
                label: 'Deactivate',
                onPressed: () => _onDeactivate(context, ref),
              ),
              const SizedBox(height: 16),
              CustomActionButton(
                label: 'Sign out',
                onPressed: () => _onSignOut(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSignOut(BuildContext context, WidgetRef ref) async {
    await ref.read(signOutUseCaseProvider)();
    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRouter.signInScreen,
          (route) => false,
    );
  }

  Future<void> _onDeactivate(BuildContext context, WidgetRef ref) async {
    final confirmed = await showAdaptiveDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog.adaptive(
        title: const Text('Deactivate account'),
        content: const Text(
          'This will permanently delete your account. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Deactivate'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final result = await ref.read(deactivateAccountUseCaseProvider)();
    if (!context.mounted) return;

    switch (result) {
      case Ok<bool>():
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRouter.signInScreen,
              (route) => false,
        );
      case Error():
        ErrorSnackBar.show(
          context,
          result.error.toString().replaceFirst('Exception: ', ''),
        );
    }
  }
}

class _GradientOutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _GradientOutlineButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      colors: [context.colorGradientBegin, context.colorGradientEnd],
    );

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 55,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: ShaderMask(
            shaderCallback: (bounds) => gradient.createShader(bounds),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
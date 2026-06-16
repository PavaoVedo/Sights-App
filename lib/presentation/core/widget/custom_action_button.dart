import 'package:flutter/material.dart';
import 'package:sights_app/presentation/core/style/extensions.dart';
import 'package:sights_app/presentation/core/widget/pressable_scale.dart';

class CustomActionButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String label;

  const CustomActionButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.label = "Sign in",
  });

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: double.maxFinite,
        height: 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [context.colorGradientBegin, context.colorGradientEnd],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(label, style: context.textButton),
      ),
    );
  }
}
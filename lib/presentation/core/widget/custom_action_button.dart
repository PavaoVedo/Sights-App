import 'package:flutter/material.dart';
import 'package:sights_app/presentation/core/style/extensions.dart';

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
    return Container(
      width: double.maxFinite,
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.colorGradientBegin, context.colorGradientEnd],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: onPressed,
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
          label,
          style: context.textButton,
        ),
      ),
    );
  }
}
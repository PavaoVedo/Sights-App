import 'package:flutter/material.dart';
import 'package:sights_app/presentation/core/style/extensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const CustomAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: Navigator.of(context).canPop()
          ? IconButton(
        icon: Icon(Icons.chevron_left, color: context.colorText, size: 30),
        onPressed: () => Navigator.of(context).pop(),
      )
          : null,
      title: title == null ? null : Text(title!, style: context.textSubtitle),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
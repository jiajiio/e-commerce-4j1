import 'package:flutter/material.dart';
import 'package:java_toys/constant/constant.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.title,
    this.hasArrowBack = true,
    this.leading,
  });

  final String title;
  final bool hasArrowBack;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: primary,
      automaticallyImplyLeading: hasArrowBack,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

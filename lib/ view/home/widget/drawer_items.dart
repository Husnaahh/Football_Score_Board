import 'package:flutter/material.dart';

import '../../../constant/app_color.dart';
import '../../../constant/app_font_family.dart';

class DrawerItems extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  final Color? iconClr;

  const DrawerItems({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
    this.iconClr,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconClr ?? AppColor.accentGreen),
      title: Text(
        title,
        style: AppFontFamily.name,
      ),
      onTap: onPressed,
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/app_color.dart';
import '../constant/app_font_family.dart';

class CommonTextfield extends StatelessWidget {
  final String txt;
  final bool obscureTxt;
  final TextEditingController controller;
  const CommonTextfield({
    super.key,
    required this.txt,
    required this.controller,
    required this.obscureTxt,
});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 8),
      child: TextField(
        cursorColor: AppColor.accentGreen,
        controller: controller,
        obscureText: obscureTxt,
        style: TextStyle(color: AppColor.white),
        decoration: InputDecoration(
          hintText: txt,
          hintStyle: AppFontFamily.txtField,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColor.accentGreen),
          )
        ),
      ),
    );
  }
}

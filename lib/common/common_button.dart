import 'package:flutter/material.dart';
import '../constant/app_color.dart';
import '../constant/app_font_family.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String txt;
  const CommonButton({super.key, required this.onPressed, required this.txt});
  
  @override 
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 270,
      child: ElevatedButton(
         style: ElevatedButton.styleFrom(
           backgroundColor: AppColor.accentGreen,
           foregroundColor: AppColor.darkGrey,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadiusGeometry.circular(14)
           )
         ),
          onPressed: onPressed,
          child: Text(txt,style: AppFontFamily.btn),
      ),
    );
  }
}
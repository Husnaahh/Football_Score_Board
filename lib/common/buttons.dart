import 'package:flutter/cupertino.dart';

import '../constant/app_color.dart';

class Buttons extends StatelessWidget {
  final VoidCallback onTap;
  final String txt;
  final Color iconClr;
  final Color txtClr;
  final IconData icon;

  const Buttons({
    super.key,
    required this.onTap,
    required this.txt,
    required this.iconClr,
    required this.txtClr,
    required this.icon,
});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 56,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: AppColor.black90,
            boxShadow: [
              BoxShadow(
                color: AppColor.black60,
                blurRadius: 20,
              ),
            ]
          ),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Icon(
                  icon,
                  color: iconClr,
                  size: 22,
                ),

                SizedBox(width: 10),

                Text(
                  txt,
                  style: TextStyle(
                    color: txtClr,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
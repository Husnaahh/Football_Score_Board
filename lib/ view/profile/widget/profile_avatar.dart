import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constant/app_color.dart';
import '../../../constant/app_font_family.dart';

class ProProfileAvatar extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  ProProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),

        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColor.accentGreen,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.accentGreen,
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),

            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(shape: BoxShape.circle),
              padding: const EdgeInsets.all(6),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  EneftyIcons.user_outline,
                  color: AppColor.white,
                  size: 55,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 20),

        Text(
          user?.displayName ?? 'Football Fan',
          style: AppFontFamily.name1,
        ),

        SizedBox(height: 8),

        Text(
          user?.email ?? 'guest@gmail.com',
          style: AppFontFamily.email1,
        ),
      ],
    );
  }
}
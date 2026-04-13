import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';

import '../../common/buttons.dart';
import '../../constant/app_color.dart';
import '../../constant/app_font_family.dart';
import '../notification/notification_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkGrey,
      appBar: AppBar(
        backgroundColor: AppColor.darkGrey,
        foregroundColor: AppColor.white,
        title: Text('Settings', style: AppFontFamily.txt1),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              Text('Account',style: AppFontFamily.txt6,),
              Buttons(
                onTap: () {},
                txt: 'Profile Information',
                iconClr: AppColor.accentGreen,
                txtClr: AppColor.accentGreen,
                icon: EneftyIcons.user_octagon_outline,
              ),

              Buttons(
                onTap: () {},
                txt: 'Change Password',
                iconClr: AppColor.accentGreen,
                txtClr: AppColor.accentGreen,
                icon: EneftyIcons.lock_2_outline,
              ),

              SizedBox(height: 30,),

              Text('Notifications',style: AppFontFamily.txt6,),
              Buttons(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(),
                    ),
                  );
                },
                txt: 'Match Alerts',
                iconClr: AppColor.accentGreen,
                txtClr: AppColor.accentGreen,
                icon: Icons.notifications_active_outlined,
              ),

              Buttons(
                onTap: () {},
                txt: 'Goal Notifications',
                iconClr: AppColor.accentGreen,
                txtClr: AppColor.accentGreen,
                icon: Icons.sports_soccer_outlined,
              ),

              SizedBox(height: 30,),

              Text('App References',style: AppFontFamily.txt6,),
              Buttons(
                onTap: () {},
                txt: 'Language',
                iconClr: AppColor.accentGreen,
                txtClr: AppColor.accentGreen,
                icon: EneftyIcons.language_circle_outline,
              ),

              Buttons(
                onTap: () {},
                txt: 'Dark Mode',
                iconClr: AppColor.accentGreen,
                txtClr: AppColor.accentGreen,
                icon: EneftyIcons.moon_outline,
              ),

              SizedBox(height: 30,),

              Text('About',style: AppFontFamily.txt6,),
              Buttons(
                onTap: () {},
                txt: 'Terms of service',
                iconClr: AppColor.accentGreen,
                txtClr: AppColor.accentGreen,
                icon: EneftyIcons.folder_minus_outline,
              ),

              Buttons(
                onTap: () {},
                txt: 'Privacy Policy',
                iconClr: AppColor.accentGreen,
                txtClr: AppColor.accentGreen,
                icon: Icons.policy_outlined,
              ),

              Buttons(
                onTap: () {},
                txt: 'App Version',
                iconClr: AppColor.accentGreen,
                txtClr: AppColor.accentGreen,
                icon: Icons.privacy_tip_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
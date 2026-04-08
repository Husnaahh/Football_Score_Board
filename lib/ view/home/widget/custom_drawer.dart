import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../../constant/app_color.dart';
import '../../../constant/app_font_family.dart';
import '../../../service/auth_service.dart';
import '../../auth/login_screen.dart';
import '../../notification/notification_screen.dart';
import '../../profile/profile_screen.dart';
import '../../settings/settings_screen.dart';
import 'drawer_items.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      backgroundColor: AppColor.black70,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppColor.black70),
            currentAccountPicture: CircleAvatar(
              backgroundColor: AppColor.accentGreen,
              child: Icon(
                EneftyIcons.user_outline,
                color: AppColor.white,
                size: 35,
              ),
            ),

            accountName: Text(
              user?.displayName ?? 'Football Fan',
              style: AppFontFamily.name,
            ),

            accountEmail: Text(
              user?.email ?? 'guest@gmail.com',
              style: AppFontFamily.email,
            ),
          ),

          DrawerItems(
            icon: EneftyIcons.user_octagon_outline,
            title: 'Profile',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),

          DrawerItems(
            icon: EneftyIcons.notification_outline,
            title: 'Notification',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),

          DrawerItems(
            icon: EneftyIcons.setting_outline,
            title: 'Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsScreen()),
              );
            },
          ),

          DrawerItems(
            icon: EneftyIcons.logout_2_outline,
            title: 'Logout',
            onPressed: () async {
              await AuthService().logout();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
                    (route) => false,
              );

              Fluttertoast.showToast(msg: 'Logout success');
            },
          ),
        ],
      ),
    );
  }
}
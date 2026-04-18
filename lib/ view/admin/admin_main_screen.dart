import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant/app_color.dart';
import '../../controller/main_screen_controller.dart';
import '../leagues/leagues_screen.dart';
import '../settings/settings_screen.dart';
import 'admin_home_screen.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const AdminHomeScreen(),
      const LeaguesScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: Consumer<MainScreenController>(
        builder: (context, value, child) => IndexedStack(
          index: value.currentIndex,
          children: pages,
        ),
      ),
      bottomNavigationBar: Consumer<MainScreenController>(
        builder: (context, value, child) => BottomNavigationBar(
          backgroundColor: AppColor.darkGrey,
          currentIndex: value.currentIndex,
          selectedItemColor: AppColor.accentGreen,
          unselectedItemColor: AppColor.shaded,
          onTap: value.changeIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.emoji_events_outlined), label: 'League'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
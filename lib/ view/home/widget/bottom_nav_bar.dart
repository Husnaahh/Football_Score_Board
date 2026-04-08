import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:football_scoreboared/constant/app_color.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColor.darkGrey,
        currentIndex: currentIndex,
        selectedItemColor: AppColor.accentGreen,
        showSelectedLabels: true,
        unselectedItemColor: AppColor.shaded,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
              icon: Icon(EneftyIcons.house_2_outline),
            label: 'Home',
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events_outlined),
            label: 'League',
          ),

          BottomNavigationBarItem(
              icon: Icon(EneftyIcons.setting_outline),
            label: 'Settings',
          ),
        ]
    );
  }
}

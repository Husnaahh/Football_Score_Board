import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/main_screen_controller.dart';
import '../../leagues/leagues_screen.dart';
import '../../settings/settings_screen.dart';
import '../home_screen.dart';
import './bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> pages =  [
    HomeScreen(),
    LeaguesScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MainScreenController>(
        builder: (context, value, child) =>
            IndexedStack(
              index: value.currentIndex,
              children: pages,
            ),
      ),
      bottomNavigationBar: Consumer<MainScreenController>(
        builder: (context, value, child) =>
            BottomNavBar(
              currentIndex: value.currentIndex,
              onTap: value.changeIndex,
            ),
      ),
    );
  }
}
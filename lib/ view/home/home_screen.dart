import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:football_scoreboared/%20view/home/widget/custom_drawer.dart';

import '../../constant/app_color.dart';
import '../../constant/app_font_family.dart';
import '../notification/notification_screen.dart';
import '../today/today_screen.dart';
import '../upcoming/upcoming_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  final user = FirebaseAuth.instance.currentUser;

  late TabController tabController; // ✅ FIXED

  StreamSubscription? _notifSub;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _listenToNotifications();
  }

  void _listenToNotifications() {
    final lastSeen = DateTime.now().subtract(const Duration(seconds: 5));

    _notifSub = FirebaseFirestore.instance
        .collection('notifications')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .snapshots()
        .listen((snapshot) {

      if (snapshot.docs.isEmpty) return;

      final doc = snapshot.docs.first;
      final createdAt = (doc['createdAt'] as Timestamp).toDate();

      if (createdAt.isAfter(lastSeen)) {
        _showNotificationBanner(doc['title'], doc['message']);
      }
    });
  }

  void _showNotificationBanner(String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColor.accentGreen,
        duration: const Duration(seconds: 4),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    _notifSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkGrey,

      drawer: const CustomDrawer(),

      appBar: AppBar(
        backgroundColor: AppColor.darkGrey,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(
              EneftyIcons.user_outline,
              color: AppColor.accentGreen,
            ),
          ),
        ),

        title: Text(
          user?.displayName ?? 'Football Fan',
          style: AppFontFamily.name,
        ),

        actions: [
          Row(
            children: [
              Icon(
                Icons.sports_soccer_outlined,
                color: AppColor.accentGreen,
              ),

              const SizedBox(width: 10),

              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotificationScreen(),
                    ),
                  );
                },
                icon: Icon(
                  EneftyIcons.notification_outline,
                  color: AppColor.accentGreen,
                ),
              ),
            ],
          ),
        ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/football.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColor.black20,
                  ),
                ),

                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Football Scores',
                        style: AppFontFamily.txt1.copyWith(
                          color: AppColor.white,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Instant football score updates',
                        style: AppFontFamily.txt.copyWith(
                          color: AppColor.shaded,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          TabBar(
            controller: tabController,
            indicatorColor: AppColor.accentGreen,
            labelColor: AppColor.accentGreen,
            unselectedLabelColor: AppColor.shaded,
            tabs: const [
              Tab(text: 'Today'),
              Tab(text: 'Upcoming'),
            ],
          ),

          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                TodayScreen(),
                UpcomingScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
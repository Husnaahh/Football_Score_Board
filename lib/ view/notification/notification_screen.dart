import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/app_color.dart';
import '../../constant/app_font_family.dart';
import '../../controller/notification_controller.dart';
import 'widget/notification_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkGrey,
      appBar: AppBar(
        backgroundColor: AppColor.darkGrey,
        foregroundColor: AppColor.white,
        title: Text('Notifications', style: AppFontFamily.txt1),
        centerTitle: true,
      ),
      body: Consumer<NotificationController>(
        builder: (context, controller, child) {
          return StreamBuilder(
            stream: controller.notifications,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: AppColor.accentGreen),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'No notifications yet',
                    style: TextStyle(color: AppColor.white),
                  ),
                );
              }

              final notifs = snapshot.data!;
              return ListView.builder(
                itemCount: notifs.length,
                itemBuilder: (context, index) {
                  final n = notifs[index];
                  return NotificationCard(
                    teamA: n.teamA,
                    teamB: n.teamB,
                    time: n.time,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
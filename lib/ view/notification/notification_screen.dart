import 'package:flutter/material.dart';
import 'package:football_scoreboared/%20view/notification/widget/notification_card.dart';
import 'package:provider/provider.dart';

import '../../constant/app_color.dart';
import '../../constant/app_font_family.dart';
import '../../controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkGrey,
      appBar: AppBar(
        backgroundColor: AppColor.darkGrey,
        foregroundColor: AppColor.white,
        title: Text('Notification', style: AppFontFamily.txt1),
        centerTitle: true,
      ),

      body: Consumer<NotificationController>(
        builder: (context, controller, child) {
          if (controller.notifications.isEmpty) {
            return Center(
              child: Text(
                'No notifications yet',
                style: AppFontFamily.txt5,
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.notifications.length,
            itemBuilder: (context, index) {
              final data = controller.notifications[index];

              return NotificationCard(
                teamA: data.teamA,
                teamB: data.teamB,
                time: data.time,
              );
            },
          );
        },
      ),
    );
  }
}
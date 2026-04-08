import 'package:flutter/material.dart';

import '../../../constant/app_color.dart';
import '../../../constant/app_font_family.dart';

class NotificationCard extends StatelessWidget {
  final String teamA;
  final String teamB;
  final String time;

  const NotificationCard({
    super.key,
    required this.teamA,
    required this.teamB,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.black70,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.accentGreen, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$teamA  vs  $teamB',
            style: AppFontFamily.txt3,
          ),
          const SizedBox(height: 6),
          Text(
            time,
            style: AppFontFamily.txt5,
          ),
        ],
      ),
    );
  }
}
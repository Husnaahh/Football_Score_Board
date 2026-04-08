import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';



import 'package:provider/provider.dart';
import '../../../constant/app_color.dart';
import '../../../constant/app_font_family.dart';
import '../../../controller/today_controller.dart';
import '../../../model/today_model.dart';

class TodayCard extends StatelessWidget {
  final TodayModel model;

  const TodayCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppColor.black90,
          boxShadow: [
            BoxShadow(
              color: AppColor.black60,
              blurRadius: 20,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'MATCHDAY',
                  style: TextStyle(
                    color: AppColor.shaded,
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.shaded,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Today',
                    style: AppFontFamily.name,
                  ),
                ),

                Consumer<TodayController>(
                  builder: (context, controller, child) {
                    return IconButton(
                      onPressed: () {
                        if (model.id != null) {
                          controller.deleteTodayMatch(model.id!);
                        }
                      },
                      icon: Icon(
                        EneftyIcons.close_circle_outline,
                        color: AppColor.accentGreen,
                      ),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      model.teamALogo ?? '',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: 12),

                    SizedBox(
                      width: 90,
                      child: Text(
                        model.teamAName ?? '',
                        style: AppFontFamily.txt5,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      model.time ?? '',
                      style: AppFontFamily.txt2,
                    ),

                    SizedBox(height: 6),

                    Text(
                      'KICKOFF',
                      style: TextStyle(
                        color: AppColor.shaded,
                        fontSize: 12,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ],
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      model.teamBLogo ?? '',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: 12),

                    SizedBox(
                      width: 90,
                      child: Text(
                        model.teamBName ?? '',
                        style: AppFontFamily.txt5,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
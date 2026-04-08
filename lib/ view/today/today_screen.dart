import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:football_scoreboared/%20view/today/widget/today_card.dart';
import 'package:provider/provider.dart';

import '../../constant/app_color.dart';
import '../../controller/today_controller.dart';
import 'add_today.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkGrey,

      body: Consumer<TodayController>(
        builder: (context, controller, child) {
          return StreamBuilder(
            stream: controller.todayMaches,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColor.accentGreen,
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    "No matches today",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              final matches = snapshot.data!;

              return ListView.builder(
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  return TodayCard(model: matches[index]);
                },
              );
            },
          );
        },
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        child: FloatingActionButton(
          backgroundColor: AppColor.accentGreen,
          onPressed: () {
            try {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddToday()),
              );
            } catch (e, s) {
              FirebaseCrashlytics.instance.recordError(e, s);
            }
          },
          child: Icon(Icons.add, color: AppColor.white),
        ),
      ),
    );
  }
}
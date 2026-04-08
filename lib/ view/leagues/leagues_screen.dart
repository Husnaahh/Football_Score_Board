import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:football_scoreboared/%20view/leagues/widget/league_card.dart';


import 'package:provider/provider.dart';import '../../constant/app_color.dart';
import '../../constant/app_font_family.dart';
import '../../controller/league_controller.dart';
import 'add_league.dart';

class LeaguesScreen extends StatelessWidget {
  const LeaguesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkGrey,

      appBar: AppBar(
        backgroundColor: AppColor.darkGrey,
        foregroundColor: AppColor.white,
        title: Text('League', style: AppFontFamily.txt1),
        centerTitle: true,
      ),

      body: Consumer<LeagueController>(
        builder: (context, controller, child) {
          return StreamBuilder(
            stream: controller.leagueMaches,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: AppColor.accentGreen),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'No Leagues',
                    style: TextStyle(color: AppColor.white),
                  ),
                );
              }

              final leagues = snapshot.data!;

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15
                ),
                itemCount: leagues.length,
                itemBuilder: (context, index) {
                  return LeagueCard(model: leagues[index]);
                },
              );
            },
          );
        },
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        child: FloatingActionButton(
          heroTag: 'Add League',
          backgroundColor: AppColor.accentGreen,
          foregroundColor: AppColor.white,
          onPressed: () {
            try {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddLeague()),
              );
            } catch (e, s) {
              FirebaseCrashlytics.instance.recordError(e, s);
            }
          },
          child: Icon(Icons.add, size: 30),
        ),
      ),
    );
  }
}
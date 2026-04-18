import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../constant/app_color.dart';
import '../../constant/app_font_family.dart';
import '../../controller/user_controller.dart';
import 'add_upcoming.dart';

class UpcomingScreen extends StatelessWidget {
  const UpcomingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final isAdmin =
        context.watch<UserController>().userModel?.role == 'admin';

    return Scaffold(
      backgroundColor: AppColor.darkGrey,

      appBar: AppBar(
        backgroundColor: AppColor.darkGrey,
        centerTitle: true,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('upcoming_matches')
            .orderBy('createdAt', descending: false)
            .snapshots()
            .handleError((error) {
          print("Firestore Error: $error");
        }),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.accentGreen,
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No upcoming matches",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final matches = snapshot.data!.docs;

          return ListView.builder(
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final data = matches[index];
              return _upcomingCard(data);
            },
          );
        },
      ),

      floatingActionButton: isAdmin
          ? FloatingActionButton(
        backgroundColor: AppColor.accentGreen,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddUpcoming(),
            ),
          );
        },
        child: const Icon(Icons.add),
      )
          : null,
    );
  }

  Widget _upcomingCard(QueryDocumentSnapshot data) {

    final map = data.data() as Map<String, dynamic>;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.black90,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [

            Text(
              "${map['date']}  |  ${map['time']}",
              style: TextStyle(color: AppColor.shaded),
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                _teamColumn(
                  map['teamAName'],
                  map['teamALogo'],
                ),

                Column(
                  children: [
                    Text(
                      "VS",
                      style: TextStyle(color: AppColor.shaded),
                    ),
                  ],
                ),

                _teamColumn(
                  map['teamBName'],
                  map['teamBLogo'],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _teamColumn(String name, String? logo) {
    return Column(
      children: [
        if (logo != null && logo.isNotEmpty)
          Image.network(
            logo,
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),

        const SizedBox(height: 8),

        SizedBox(
          width: 90,
          child: Text(
            name,
            style: AppFontFamily.txt5,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/app_color.dart';
import '../../constant/app_font_family.dart';
import '../../controller/today_controller.dart';
import '../../model/today_model.dart';
import '../auth/login_screen.dart';
import '../today/add_today.dart';
import '../upcoming/add_upcoming.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.darkGrey,
        appBar: AppBar(
          backgroundColor: AppColor.darkGrey,
          title: Text("Admin Dashboard", style: AppFontFamily.name),
          centerTitle: true,

          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.red),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                      (route) => false,
                );
              },
            ),
          ],

          bottom: const TabBar(
            tabs: [
              Tab(text: "Today Matches"),
              Tab(text: "Upcoming Matches"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _TodayMatchesTab(),
            _UpcomingMatchesTab(),
          ],
        ),
        floatingActionButton: Builder(
          builder: (context) {
            final tabIndex = DefaultTabController.of(context).index;
            return FloatingActionButton(
              backgroundColor: AppColor.accentGreen,
              onPressed: () {
                if (tabIndex == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddToday()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddUpcoming()),
                  );
                }
              },
              child: const Icon(Icons.add, color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}

class _TodayMatchesTab extends StatelessWidget {
  const _TodayMatchesTab();

  @override
  Widget build(BuildContext context) {
    return Consumer<TodayController>(
      builder: (context, controller, child) {
        return StreamBuilder<List<TodayModel>>(
          stream: controller.todayMatches,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: AppColor.accentGreen),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No matches available",
                    style: TextStyle(color: Colors.white)),
              );
            }

            final matches = snapshot.data!;
            return ListView.builder(
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];
                return _adminMatchCard(context, match, controller, true);
              },
            );
          },
        );
      },
    );
  }
}

class _UpcomingMatchesTab extends StatelessWidget {
  const _UpcomingMatchesTab();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('upcoming_matches')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: AppColor.accentGreen),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No upcoming matches",
                style: TextStyle(color: Colors.white)),
          );
        }

        final matches = snapshot.data!.docs;
        return ListView.builder(
          itemCount: matches.length,
          itemBuilder: (context, index) {
            final match = matches[index];
            return _adminMatchCard(
              context,
              TodayModel.fromFirestore(match),
              null,
              false,
            );
          },
        );
      },
    );
  }
}

Widget _adminMatchCard(
    BuildContext context,
    TodayModel model,
    TodayController? controller,
    bool allowScoreUpdate,
    ) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("MATCH", style: TextStyle(color: AppColor.shaded)),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: AppColor.accentGreen),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      if (model.id != null && controller != null) {
                        controller.deleteTodayMatch(model.id!);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text("${model.date ?? ''} | ${model.time ?? ''}",
              style: TextStyle(color: AppColor.shaded)),
          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _teamColumn(model.teamAName, model.teamALogo),
              Text("VS", style: TextStyle(color: AppColor.shaded)),
              _teamColumn(model.teamBName, model.teamBLogo),
            ],
          ),

          const SizedBox(height: 10),
          Text(
            "${model.scoreA ?? 0} - ${model.scoreB ?? 0}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          if (allowScoreUpdate)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.accentGreen,
              ),
              onPressed: () {
                final scoreAController = TextEditingController(
                    text: (model.scoreA ?? 0).toString());
                final scoreBController = TextEditingController(
                    text: (model.scoreB ?? 0).toString());

                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColor.black90,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Update Score",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _scoreField("Team A Score", scoreAController),
                            const SizedBox(height: 15),
                            _scoreField("Team B Score", scoreBController),
                            const SizedBox(height: 25),

                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel",
                                        style: TextStyle(
                                            color: AppColor.shaded)),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      int scoreA =
                                          int.tryParse(scoreAController.text) ?? 0;
                                      int scoreB =
                                          int.tryParse(scoreBController.text) ?? 0;

                                      if (model.id == null) return;

                                      await FirebaseFirestore.instance
                                          .collection('today_matches')
                                          .doc(model.id)
                                          .update({
                                        'scoreA': scoreA,
                                        'scoreB': scoreB,
                                      });

                                      Navigator.pop(context);

                                      if (controller != null) {
                                        controller.notifyListeners();
                                      }

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Score Updated Successfully"),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.accentGreen,
                                    ),
                                    child: const Text("Update"),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text(
                "Update Score",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _teamColumn(String? name, String? logo) {
  return Column(
    children: [
      Image.network(logo ?? '', width: 40, height: 40),
      const SizedBox(height: 8),
      Text(name ?? '', style: AppFontFamily.txt5),
    ],
  );
}

Widget _scoreField(String label, TextEditingController controller) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: AppColor.shaded),
      filled: true,
      fillColor: Colors.black,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}